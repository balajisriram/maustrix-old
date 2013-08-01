function out = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir)
out = [];
if ~exist('plotDetails','var')||isempty(plotDetails)
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'makeFigure';
end

if ~exist('trialNumCutoff','var')||isempty(trialNumCutoff)
    trialNumCutoff = 25;
end

if ~exist('filters','var') || isempty(filters)
    % all data is allowed
    filters.fdFilter = 1:today;
    filters.imFilter = 1:today;
    filters.optFilter = 1:today;
    filters.optRevFilter = 1:today;
    filters.ctrFilter = 1:today;
    filters.ctrRevFilter = 1:today;
    filters.sfFilter = 1:today;
    filters.sfRevFilter = 1:today;
    filters.orFilter = 1:today;
    filters.orRevFilters = 1:today;
    filters.tfFilter = 1:today;
    filters.tfRevFilter = 1:today;
elseif isnumeric(filters)
    temp = filters;
    filters.fdFilter = temp;
    filters.imFilter = temp;
    filters.optFilter = temp;
    filters.optRevFilter = temp;
    filters.ctrFilter = temp;
    filters.ctrRevFilter = temp;
    filters.sfFilter = temp;
    filters.sfRevFilter = temp;
    filters.orFilter = temp;
    filters.orRevFilters = temp;
    filters.tfFilter = temp;
    filters.tfRevFilter = temp;
    clear temp
end

if ~exist('analysisFor','var')||isempty(analysisFor)
    analyzeImages = true;
    analyzeOpt = true;
    analyzeRevOpt = true;
    analyzeContrast = true;
    analyzeRevContrast = true;
    analyzeSpatFreq = true;
    analyzeRevSpatFreq = true;
    analyzeOrientation = true;
    analyzeRevOrientation = true;
    analyzeTempFreq = true;
    analyzeRevTempFreq = true;
else
    analyzeImages = analysisFor.analyzeImages;
    analyzeOpt = analysisFor.analyzeOpt;
    analyzeRevOpt = analysisFor.analyzeRevOpt;
    analyzeContrast = analysisFor.analyzeContrast;
    analyzeRevContrast = analysisFor.analyzeRevContrast;
    analyzeSpatFreq = analysisFor.analyzeSpatFreq;
    analyzeRevSpatFreq = analysisFor.analyzeRevSpatFreq;
    analyzeOrientation = analysisFor.analyzeOrientation;
    analyzeRevOrientation = analysisFor.analyzeRevOrientation;
    analyzeTempFreq = analysisFor.analyzeTempFreq;
    analyzeRevTempFreq = analysisFor.analyzeRevTempFreq;
end

if ~exist('splits','var')||isempty(splits)
    daysPBS = [];
    daysCNO = [];
    daysIntact = [];
    daysLesion = [];
else
    daysPBS = splits.daysPBS;
    daysCNO = splits.daysCNO;
    daysIntact = splits.daysIntact;
    daysLesion = splits.daysLesion;    
end

if iscell(mouseID) && length(mouseID)>1
    data = collateData(compiledFilesDir,mouseID);
    temp = sprintf('%s',mouseID{1});
    for i = 2:length(mouseID)
        temp = sprintf('%s-%s',temp,mouseID{i});
    end
    mouseID = 'ALL MICE';
else
    data = load(findCompiledRecordsForSubject(compiledFilesDir,mouseID));
end

%% IMAGES
if analyzeImages
    out.imageData = analyzeImagesTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end
%% +/- 45 GRATINGS
if analyzeOpt
    out.optData = analyzeOptTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% REVERSAL +/- 45 GRATINGS
if analyzeRevOpt
    out.optReversalData = analyzeOptReversalTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% CONTRAST
if analyzeContrast
    out.ctrData = analyzeContrastTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end
%% REVERSAL CONTRAST
if analyzeRevContrast
    out.ctrRevData = analyzeContrastReversalTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% SPAT.FREQ.
if analyzeSpatFreq
    out.spatData = analyzeSpatFreqTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% REV. SPAT. FREQ.
if analyzeRevSpatFreq
    out.spatRevData = analyzeSpatFreqReversalTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% ORIENTATION
if analyzeOrientation
    out.orData = analyzeOrientationTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% REVERSAL ORIENTATION
if analyzeRevOrientation
    out.orRevData = analyzeOrientationReversalTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% TEMP FREQ
if analyzeTempFreq
    out.tfData = analyzeTempFreqTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

%% REVERSAL TEMP FREQ
if analyzeRevTempFreq
    out.tfRevData = analyzeTempFreqReversalTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end
end

function out = collateData(compiledFilesDir,mouseID)
out = load(findCompiledRecordsForSubject(compiledFilesDir{1},mouseID{1}));
maxLUTNum = length(out.compiledLUT);
maxTrialNum = max(out.compiledTrialRecords.trialNumber);
for i = 2:length(mouseID)
    tempCurr = load(findCompiledRecordsForSubject(compiledFilesDir{i},mouseID{i}));
    
    % update the compiledTrialRecords
    out.compiledTrialRecords.trialNumber = [out.compiledTrialRecords.trialNumber tempCurr.compiledTrialRecords.trialNumber + maxTrialNum];
    out.compiledTrialRecords.sessionNumber = [out.compiledTrialRecords.sessionNumber tempCurr.compiledTrialRecords.sessionNumber];
    out.compiledTrialRecords.date = [out.compiledTrialRecords.date tempCurr.compiledTrialRecords.date];
    out.compiledTrialRecords.soundOn = [out.compiledTrialRecords.soundOn tempCurr.compiledTrialRecords.soundOn];
    out.compiledTrialRecords.physicalLocation = [out.compiledTrialRecords.physicalLocation tempCurr.compiledTrialRecords.physicalLocation];
    out.compiledTrialRecords.numPorts = [out.compiledTrialRecords.numPorts tempCurr.compiledTrialRecords.numPorts];
    out.compiledTrialRecords.step = [out.compiledTrialRecords.step tempCurr.compiledTrialRecords.step];
    out.compiledTrialRecords.trainingStepName = [out.compiledTrialRecords.trainingStepName tempCurr.compiledTrialRecords.trainingStepName + maxLUTNum];
    out.compiledTrialRecords.protocolName = [out.compiledTrialRecords.protocolName tempCurr.compiledTrialRecords.protocolName + maxLUTNum];
    out.compiledTrialRecords.numStepsInProtocol = [out.compiledTrialRecords.numStepsInProtocol tempCurr.compiledTrialRecords.numStepsInProtocol];
    out.compiledTrialRecords.manualVersion = [out.compiledTrialRecords.manualVersion tempCurr.compiledTrialRecords.manualVersion];
    out.compiledTrialRecords.autoVersion = [out.compiledTrialRecords.autoVersion tempCurr.compiledTrialRecords.autoVersion];
    out.compiledTrialRecords.protocolDate = [out.compiledTrialRecords.protocolDate tempCurr.compiledTrialRecords.protocolDate];
    out.compiledTrialRecords.correct = [out.compiledTrialRecords.correct tempCurr.compiledTrialRecords.correct];
    out.compiledTrialRecords.trialManagerClass = [out.compiledTrialRecords.trialManagerClass tempCurr.compiledTrialRecords.trialManagerClass+maxLUTNum];
    out.compiledTrialRecords.stimManagerClass = [out.compiledTrialRecords.stimManagerClass tempCurr.compiledTrialRecords.stimManagerClass+maxLUTNum];
    out.compiledTrialRecords.schedulerClass = [out.compiledTrialRecords.schedulerClass tempCurr.compiledTrialRecords.schedulerClass+maxLUTNum];
    out.compiledTrialRecords.criterionClass = [out.compiledTrialRecords.criterionClass tempCurr.compiledTrialRecords.criterionClass+maxLUTNum];
    out.compiledTrialRecords.reinforcementManagerClass = [out.compiledTrialRecords.reinforcementManagerClass tempCurr.compiledTrialRecords.reinforcementManagerClass+maxLUTNum];
    out.compiledTrialRecords.targetPorts = [out.compiledTrialRecords.targetPorts tempCurr.compiledTrialRecords.targetPorts];
    out.compiledTrialRecords.distractorPorts = [out.compiledTrialRecords.distractorPorts tempCurr.compiledTrialRecords.distractorPorts];
    out.compiledTrialRecords.result = [out.compiledTrialRecords.result tempCurr.compiledTrialRecords.result];
    out.compiledTrialRecords.containedAPause = [out.compiledTrialRecords.containedAPause tempCurr.compiledTrialRecords.containedAPause];
    out.compiledTrialRecords.containedManualPokes = [out.compiledTrialRecords.containedManualPokes tempCurr.compiledTrialRecords.containedManualPokes];
    out.compiledTrialRecords.didHumanResponse = [out.compiledTrialRecords.didHumanResponse tempCurr.compiledTrialRecords.didHumanResponse];
    out.compiledTrialRecords.containedForcedRewards = [out.compiledTrialRecords.containedForcedRewards tempCurr.compiledTrialRecords.containedForcedRewards];
    out.compiledTrialRecords.didStochasticResponse = [out.compiledTrialRecords.didStochasticResponse tempCurr.compiledTrialRecords.didStochasticResponse];
    out.compiledTrialRecords.correctionTrial = [out.compiledTrialRecords.correctionTrial tempCurr.compiledTrialRecords.correctionTrial];
    out.compiledTrialRecords.numRequests = [out.compiledTrialRecords.numRequests tempCurr.compiledTrialRecords.numRequests];
    out.compiledTrialRecords.firstIRI = [out.compiledTrialRecords.firstIRI tempCurr.compiledTrialRecords.firstIRI];
    out.compiledTrialRecords.responseTime = [out.compiledTrialRecords.responseTime tempCurr.compiledTrialRecords.responseTime];
    out.compiledTrialRecords.actualRewardDuration = [out.compiledTrialRecords.actualRewardDuration tempCurr.compiledTrialRecords.actualRewardDuration];
    out.compiledTrialRecords.proposedRewardDuration = [out.compiledTrialRecords.proposedRewardDuration tempCurr.compiledTrialRecords.proposedRewardDuration];
    out.compiledTrialRecords.proposedPenaltyDuration = [out.compiledTrialRecords.proposedPenaltyDuration tempCurr.compiledTrialRecords.proposedPenaltyDuration];
    out.compiledTrialRecords.response = [out.compiledTrialRecords.response tempCurr.compiledTrialRecords.response];
    
    % update the compiledLUT
    out.compiledLUT = {(out.compiledLUT{:}),(tempCurr.compiledLUT{:})};
    
    % update compiledDetails
    classNames = {out.compiledDetails.className};
    for j = 1:length(tempCurr.compiledDetails)
        % curr class name
        currClassName = tempCurr.compiledDetails(j).className;
        whichInOlder = find(ismember(classNames,currClassName));
        if ~isempty(whichInOlder)
            switch currClassName
                case 'orientedGabors'
                case 'images'
                    out.compiledDetails(whichInOlder).records.correctionTrial = [out.compiledDetails(whichInOlder).records.correctionTrial tempCurr.compiledDetails(j).records.correctionTrial];
                    out.compiledDetails(whichInOlder).records.pctCorrectionTrials = [out.compiledDetails(whichInOlder).records.pctCorrectionTrials tempCurr.compiledDetails(j).records.pctCorrectionTrials];
                    out.compiledDetails(whichInOlder).records.leftIm = [out.compiledDetails(whichInOlder).records.leftIm tempCurr.compiledDetails(j).records.leftIm];
                    out.compiledDetails(whichInOlder).records.rightIm = [out.compiledDetails(whichInOlder).records.rightIm tempCurr.compiledDetails(j).records.rightIm];
                    out.compiledDetails(whichInOlder).records.suffices = [out.compiledDetails(whichInOlder).records.suffices tempCurr.compiledDetails(j).records.suffices];
                case 'afcGratings'
                    tempCurr.compiledDetails(j).records.afcGratingType = tempCurr.compiledDetails(j).records.afcGratingType+maxLUTNum;
                    
                    out.compiledDetails(whichInOlder).records.correctionTrial      = [out.compiledDetails(whichInOlder).records.correctionTrial       tempCurr.compiledDetails(j).records.correctionTrial     ];
                    out.compiledDetails(whichInOlder).records.pctCorrectionTrials  = [out.compiledDetails(whichInOlder).records.pctCorrectionTrials   tempCurr.compiledDetails(j).records.pctCorrectionTrials ];
                    out.compiledDetails(whichInOlder).records.doCombos             = [out.compiledDetails(whichInOlder).records.doCombos              tempCurr.compiledDetails(j).records.doCombos            ];
                    out.compiledDetails(whichInOlder).records.pixPerCycs           = [out.compiledDetails(whichInOlder).records.pixPerCycs            tempCurr.compiledDetails(j).records.pixPerCycs          ];
                    out.compiledDetails(whichInOlder).records.driftfrequencies     = [out.compiledDetails(whichInOlder).records.driftfrequencies      tempCurr.compiledDetails(j).records.driftfrequencies    ];
                    out.compiledDetails(whichInOlder).records.orientations         = [out.compiledDetails(whichInOlder).records.orientations          tempCurr.compiledDetails(j).records.orientations        ];
                    out.compiledDetails(whichInOlder).records.phases               = [out.compiledDetails(whichInOlder).records.phases                tempCurr.compiledDetails(j).records.phases              ];
                    out.compiledDetails(whichInOlder).records.contrasts            = [out.compiledDetails(whichInOlder).records.contrasts             tempCurr.compiledDetails(j).records.contrasts           ];
                    out.compiledDetails(whichInOlder).records.maxDuration          = [out.compiledDetails(whichInOlder).records.maxDuration           tempCurr.compiledDetails(j).records.maxDuration         ];
                    out.compiledDetails(whichInOlder).records.radii                = [out.compiledDetails(whichInOlder).records.radii                 tempCurr.compiledDetails(j).records.radii               ];
                    out.compiledDetails(whichInOlder).records.annuli               = [out.compiledDetails(whichInOlder).records.annuli                tempCurr.compiledDetails(j).records.annuli              ];
                    out.compiledDetails(whichInOlder).records.afcGratingType       = [out.compiledDetails(whichInOlder).records.afcGratingType        tempCurr.compiledDetails(j).records.afcGratingType      ];
                otherwise
                    currClassName
                    error('dont knowhow to deal with this class');
            end
            out.compiledDetails(whichInOlder).trialNums = [out.compiledDetails(whichInOlder).trialNums tempCurr.compiledDetails(j).trialNums+maxTrialNum];
            out.compiledDetails(whichInOlder).bailedTrialNums = [out.compiledDetails(whichInOlder).bailedTrialNums tempCurr.compiledDetails(j).bailedTrialNums+maxTrialNum];
        else
            switch currClassName
                case 'orientedGabors'
                case 'images'
                case 'afcGratings'
                    tempCurr.compiledDetails(j).records.afcGratingType = tempCurr.compiledDetails(j).records.afcGratingType+maxLUTNum;
                otherwise
                    currClassName
                    error('dont knowhow to deal with this class');
            end
            out.compiledDetails(end+1) = tempCurr.compiledDetails(j);
        end
    end
    
    % update the running tallys now
    maxLUTNum = length(out.compiledLUT);
    maxTrialNum = max(out.compiledTrialRecords.trialNumber);
end
end