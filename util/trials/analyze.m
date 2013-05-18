function varargout =  analyze(subjectID, path, inputParams, outputParams, otherParams)
    
    %% START ERROR CHECKING AND CORRECTION
if ~exist('subjectID','var') || isempty(subjectID)
    error('need a subjectID');
end

if ~exist('recordsPath','var') || isempty(recordsPath) || ~isdir(recordsPath)
    error('need to specify the folder ''recordsPath''');
end

% make sure that the subject 
subjectRecordsPath = fullfile(recordsPath, subjectID);
if ~isdir(subjectRecordsPath)
    subjectRecordsPath
    error('unable to find directory to subject');
end
    %% cellBoundary with support for masking
if ~exist('cellBoundary','var') || isempty(cellBoundary)
    error('cellBoundary must be a valid input argument - default value is too dangerous here!');
else 
    [boundaryRange maskInfo] = validateCellBoundary(cellBoundary);
end
    %% spikeChannelsAnalyzed
if ~exist('trodes','var') || isempty(trodes)
    channelAnalysisMode = 'allPhysChannels';
    trodes={}; % default all phys channels one by one. will be set when we know how many channels
else
    channelAnalysisMode = 'onlySomeChannels';
    % error check
    if ~(iscell(trodes))
        error('must be a cell of groups of channels');
    elseif length(trodes)>1
        warning('going to try multiple leads in analysis...');
    end
        
end
    %% create the analysisPath and see if it exists
[analysisPath analysisDirForRange]= createAnalysisPathString(boundaryRange,path,subjectID);
prevAnalysisExists =  exist(analysisPath,'dir');
    %% should we backup the analysis?
if prevAnalysisExists && makeBackup
    backupPath = fullfile(path,subjectID,'analysis','backups',sprintf('analysisDirForRange-%s',datestr(now,30)));
    makedir(backupPath);
    [succ,msg,msgID] = moviefile(analysisPath, backupPath);  % includes all subdirectory regardless of permissions
    if ~succ
        msg
        error('failed to make backup')
    end
end
    %% validate spikeDetection and spikeSorting Params
if ~exist('spikeDetectionParams','var')
    spikeDetectionParams = [];
end

if ~exist('spikeSortingParams','var')
    spikeSortingParams = [];
end
[validatedParams spikeDetectionParams spikeSortingParams trodes] = validateAndSetDetectionAndSortingParams(spikeDetectionParams,...
    spikeSortingParams,channelAnalysisMode,trodes,analysisPath); 
    %% createAnalysisPaths here
switch analysisMode 
    case {'overwriteAll','detectAndSortOnFirst','detectAndSortOnOnAll','interactiveDetectAndSortOnFirst',...
            'interactiveDetectAndSortOnAll', 'analyzeAtEnd','onlyDetectAndSort','onlyDetect'}
        % if a previous analysis exists, delete it
        if prevAnalysisExists
            [succ,msg,msgID] = rmdir(analysisPath,'s');  % includes all subdirectory regardless of permissions
            if ~succ
                msg
                error('failed to remove existing files when running with ''overwriteAll=true''')
            end
            prevAnalysisExists = false;
        end
        % recreate the analysis file
        mkdir(analysisPath);
    case {'viewAnalysisOnly','onlyAnalyze','onlySort','onlyInspect','onlyInspectInteractive'}
        % do nothing
    otherwise
        error('unknown analysisMode: ''%s''',analysisMode)
end
    %% timeRangePerTrialSecs
if ~exist('timeRangePerTrialSecs','var') || isempty(timeRangePerTrialSecs)
    timeRangePerTrialSecs = [0 Inf]; %all
else
    if timeRangePerTrialSecs(1)~=0
        error('frame pulse detection has not been validated if you do not start at time=0')
        %do we throw out the first pulse?
    end
    if timeRangePerTrialSecs(2)<3
        requestedEndDuration= timeRangePerTrialSecs(2)
        error('frame pulse detection has not been validated if you do not have at least some pulses')
        %do we throw out the first pulse?
    end
end
    %% stimClassToAnalyze
if ~exist('stimClassToAnalyze','var') || isempty(stimClassToAnalyze)
    stimClassToAnalyze='all';
else
    if ~(iscell(stimClassToAnalyze) ) % and they are all chars
        stimClassToAnalyze
        error('must be a cell of chars of SM classes or ''all'' ')
    end
end
    %% usePhotoDiodeSpikes
if ~exist('usePhotoDiodeSpikes','var') || isempty(usePhotoDiodeSpikes)
    if strcmp(analysisMode,'usePhotoDiodeSpikes')
        usePhotoDiodeSpikes=true;
    else
        usePhotoDiodeSpikes = false;
    end
end
    %% otherParams
if ~exist('otherParams','var') || isempty(otherParams)
    otherParams.showSpikeAnalysis = true;
    otherParams.showLFPAnalysis = true;
    otherParams.plotSortingForTesting = true;
    otherParams.pauseForInspect = false;
    otherParams.forceNoInspect = false;
    otherParams.saveFigs = true;
    otherParams.forceErrorOnNoAnalysis = true;
end
    %% frameThresholds
if ~exist('frameThresholds','var') || isempty(frameThresholds)
    frameThresholds.dropBound = 1.5;   %smallest fractional length of ifi that will cause the long tail to be called a drop(s)
    frameThresholds.warningBound = 0.1; %fractional difference that will cause a warning, (after drop adjusting)
    frameThresholds.errorBound = 0.5;   %fractional difference of ifi that will cause an error (after drop adjusting)
    frameThresholds.dropsAcceptableFirstNFrames=2; % first 2 frames won't kill the default quality test               
end
    %% eyeRecordPath
eyeRecordPath = fullfile(path,subjectID,'eyeRecords');
if ~isdir(eyeRecordPath)
    mkdir(eyeRecordPath);
end
    %% pauseForInspect
if ~exist('pauseForInspect','var')||isempty(pauseForInspect)
    pauseForInspect = false;
end
%% END ERROR CHECKING
end