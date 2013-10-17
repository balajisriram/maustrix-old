function standAloneRun(ratrixPath,setupFile,subjectID,recordInOracle,backupToServer,testMode)
%standAloneRun([ratrixPath],[setupFile],[subjectID],[recordInOracle],[backupToServer])
%
% ratrixPath (optional, string path to preexisting ratrix 'db.mat' file)
% defaults to checking for db.mat in ...\<ratrix install directory>\..\ratrixData\ServerData\
% if none present, makes new ratrix located there, with a dummy subject
%
% setupFile (optional, name of a setProtocol file on the path, typically in the setup directory)
% defaults to 'setProtocolDEMO'
% if subject already exists in ratrix and has a protocol, default is no action
%
% subjectID (optional, must be string id of subject -- will add to ratrix if not already present)
% default is some unspecified subject in ratrix (you can't depend on which
% one unless there is only one)
%
% recordInOracle (optional, must be logical, default false)
% if true, subject must be in oracle database and history file name loading from
% database will be exercised.
%
% backupOnServer (optional, must be logical or a path to the server, default false)
% if true, will also replicate to a hard-coded server path
% all trial record indexing (standAlonePath) is still handled locally

%
setupEnvironment;

if ~exist('recordInOracle','var') || isempty(recordInOracle)
    recordInOracle = false;
elseif ~islogical(recordInOracle)
    error('recordInOracle must be logical')
end

if ~exist('backupToServer','var') || isempty(backupToServer)
    backupToServer = true;
    [a, b] = getMACaddress();
    switch b
        case 'A41F7278B4DE' %gLab-Behavior1
            xtraServerBackupPath='\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box1\Permanent';
        case 'A41F729213E2' %gLab-Behavior2 'A41F729213E2','001D7DA80EFC'
            xtraServerBackupPath='\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box2\Permanent';
        case 'A41F726EC11C' %gLab-Behavior3
            xtraServerBackupPath='\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box3\Permanent';
        case '7845C4256F4C' %gLab-Behavior4
            xtraServerBackupPath='\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Permanent';
        case '7845C42558DF' %gLab-Behavior5
            xtraServerBackupPath='\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Permanent';
        case 'BC305BD38BFB' %ephys-stim
            xtraServerBackupPath='\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\ephys-stim\Permanent';
        case '180373337162' %ephys-data
            backupToServer = false;
        otherwise
            warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
            keyboard;
    end
elseif islogical(backupToServer);
    xtraServerBackupPath='\\Reinagel-lab.AD.ucsd.edu\RLAB\Rodent-Data\behavior\standAloneRecords';
elseif isDirRemote(backupToServer)
    xtraServerBackupPath=backupToServer;
    backupToServer=true;
else
    error('backupToServer must be logical or a valid path')
end

if ~exist('testMode','var') || isempty(testMode)
    testMode = false;
end

if exist('ratrixPath','var') && ~isempty(ratrixPath)
    if isdir(ratrixPath)
        rx=ratrix(ratrixPath,0);
    else
        ratrixPath
        error('if ratrixPath supplied, it must be a path to a preexisting ratrix ''db.mat'' file')
    end
else
    dataPath=fullfile(fileparts(fileparts(getRatrixPath)),'ratrixData',filesep);
    defaultLoc=fullfile(dataPath, 'ServerData');
    d=dir(fullfile(defaultLoc, 'db.mat'));

    if length(d)==1
        rx=ratrix(defaultLoc,0);
        fprintf('loaded ratrix from default location\n')
    else
        try
            [success mac]=getMACaddress();
            if ~success
                mac='000000000000';
            end
        catch
            mac='000000000000';
        end

        machines={{'1U',mac,[1 1 1]}};
        rx=createRatrixWithDefaultStations(machines,dataPath,'localTimed');
        permStorePath=fullfile(dataPath,'PermanentTrialRecordStore');
        mkdir(permStorePath);
        rx=setStandAlonePath(rx,permStorePath);
        fprintf('created new ratrix\n')
    end
end

needToAddSubject=false;
needToCreateSubject=false;
if ~exist('subjectID','var') || isempty(subjectID)
    ids=getSubjectIDs(rx);
    if length(ids)>0
        subjectID=ids{1};
    else
        subjectID='demo1';
        needToCreateSubject=true;
        needToAddSubject=true;
    end
else
    subjectID=lower(subjectID);
    try
        isSubjectInRatrix=getSubjectFromID(rx,subjectID);
    catch ex
        if ~isempty(strfind(ex.message,'request for subject id not contained in ratrix'))
            if recordInOracle
                sub =createSubjectsFromDB({subjectID});
                if isempty(sub)
                    subjectID
                    error('subject not defined in oracle database')
                else
                    needToAddSubject=true;
                end
            else
                needToCreateSubject=true;
                needToAddSubject=true;
            end
        else
            rethrow(ex)
        end
    end
end
if needToCreateSubject
    warning('creating dummy subject')
    sub = subject(subjectID, 'rat', 'long-evans', 'male', '05/10/2005', '01/01/2006', 'unknown', 'wild caught');
end
auth='bas';

if needToAddSubject
    rx=addSubject(rx,sub,auth);
end

if (~exist('setupFile','var') || isempty(setupFile)) && ~isa(getProtocolAndStep(getSubjectFromID(rx,subjectID)),'protocol')
    setupFile='setProtocolDEMO';
end

if exist('setupFile','var') && ~isempty(setupFile)
    x=what(fileparts(which(setupFile)));
    if isempty(x) || isempty({x.m}) || ~any(ismember(lower({setupFile,[setupFile '.m']}),lower(x.m)))
        setupFile
        error('if setupFile supplied, it must be the name of a setProtocol file on the path (typically in the setup directory)')
    end

    su=str2func(setupFile); %weird, str2func does not check for existence!
    rx=su(rx,{subjectID});
    %was:  r=feval(setupFile, r,{getID(sub)});
    %but edf notes: eval is bad style
    %http://www.mathworks.com/support/tech-notes/1100/1103.html
    %http://blogs.mathworks.com/loren/2005/12/28/evading-eval/
end

try
    deleteOnSuccess = true; 
    
    if backupToServer
        replicationPaths={getStandAlonePath(rx),xtraServerBackupPath};
    else
        replicationPaths={getStandAlonePath(rx)};
    end

    replicateTrialRecords(replicationPaths,deleteOnSuccess, recordInOracle);

    s=getSubjectFromID(rx,subjectID);

    [rx ids] = emptyAllBoxes(rx,'starting trials in standAloneRun',auth);
    boxIDs=getBoxIDs(rx);
    rx=putSubjectInBox(rx,subjectID,boxIDs(1),auth);    
    b=getBoxIDForSubjectID(rx,getID(s));
    st=getStationsForBoxID(rx,b);
    %struct(st(1))
    rx=doTrials(st(1),rx,0,[],~recordInOracle); %0 means keep running trials til something stops you (quit, error, etc)
    
    [rx ids] = emptyAllBoxes(rx,'done running trials in standAloneRun',auth);
    if ~testMode
        replicateTrialRecords(replicationPaths,deleteOnSuccess, recordInOracle);
        compilePath=fullfile(fileparts(getStandAlonePath(rx)),'CompiledTrialRecords');
        mkdir(compilePath);
        %     compileTrialRecords([],[],[],{subjectID},getStandAlonePath(rx),compilePath);
        dailyAnalysisPath = fullfile(fileparts(getStandAlonePath(rx)),'DailyAnalysis');
        mkdir(dailyAnalysisPath);
        compileDetailedRecords([],{subjectID},[],getStandAlonePath(rx),compilePath);
        % removed daily plotting and subject analysis
%         plotAndSaveDailyReport(compilePath,dailyAnalysisPath,subjectID);
        subjectAnalysis(compilePath);
    end
    cleanup;
    % testing
    clear all
catch ex
    disp(['CAUGHT ERROR: ' getReport(ex,'extended')])
    
    [~, b] = getMACaddress();
    c = clock;
    message = sprintf('Failed for subject:: %s at time::%d:%d on %d-%d-%d',subjectID,c(4),c(5),c(2),c(3),c(1));
    switch b
        case 'A41F7278B4DE' %gLab-Behavior1
            gmail('balajisriram@gmail.com','Screen error in Rig 1',message);
        case 'A41F729213E2' %gLab-Behavior2
            gmail('balajisriram@gmail.com','Screen error in Rig 2',message);
        case 'A41F726EC11C' %gLab-Behavior3
            gmail('balajisriram@gmail.com','Screen error in Rig 3',message);
        case '7845C4256F4C' %gLab-Behavior4
            gmail('balajisriram@gmail.com','Screen error in Rig 4',message);
        case '7845C42558DF' %gLab-Behavior5
            gmail('balajisriram@gmail.com','Screen error in Rig 5',message);
        otherwise
            warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
            keyboard;
    end
    warning('this is weird, but going to retry starting the stimulus again.... will this work?')
    standAloneRun(ratrixPath,setupFile,subjectID,recordInOracle,backupToServer,testMode);
    cleanup;
    rethrow(ex)
end

function cleanup
sca
FlushEvents('mouseUp','mouseDown','keyDown','autoKey','update');
ListenChar(0)
ShowCursor(0)