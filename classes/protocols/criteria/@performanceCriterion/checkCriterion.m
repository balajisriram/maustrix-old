function [graduate details] = checkCriterion(c,subject,trainingStep,trialRecords, compiledRecords)

fieldNames = fields(trialRecords);

forcedRewards = 0;
stochastic = 0;
humanResponse = 0;

warnStatus = false;

trialsInTR = [trialRecords.trialNumber];
trialsFromCR = compiledRecords.compiledTrialRecords.trialNumber;
trialsFromCRToBeIncluded = ~ismember(trialsFromCR,trialsInTR);

allStepNums = [compiledRecords.compiledTrialRecords.step(trialsFromCRToBeIncluded) trialRecords.trainingStepNum];

td = [trialRecords.trialDetails];
for tnum = 1:length(td)
    if isempty(td(tnum).correct)
        td(tnum).correct = nan;
    end
end
allCorrects = [compiledRecords.compiledTrialRecords.correct(trialsFromCRToBeIncluded) td.correct];


if ismember({'containedForcedRewards'},fieldNames)
    ind = find(cellfun(@isempty,{trialRecords.containedForcedRewards}));
    if ~isempty(ind)
        warning('using pessimistic values for containedForcedRewards');
        for i=1:length(ind)
            trialRecords(ind(i)).containedForcedRewards = 1;
        end
    end
    forcedRewards = [trialRecords.containedForcedRewards]==1;
else 
    warnStatus = true;
end
allForcedRewards = [compiledRecords.compiledTrialRecords.containedForcedRewards(trialsFromCRToBeIncluded) forcedRewards];

if ismember({'didStochasticResponse'},fieldNames)
    ind = find(cellfun(@isempty,{trialRecords.didStochasticResponse}));
    if ~isempty(ind)
        warning('using pessimistic values for didStochasticResponse');
        for i=1:length(ind)
            trialRecords(ind(i)).didStochasticResponse = 1;
        end
    end
    stochastic = [trialRecords.didStochasticResponse];
else 
    warnStatus = true;
end
allStochastic = [compiledRecords.compiledTrialRecords.didStochasticResponse(trialsFromCRToBeIncluded) stochastic];


if ismember({'didHumanResponse'},fieldNames)
    ind = find(cellfun(@isempty,{trialRecords.didHumanResponse}));
    if ~isempty(ind)
        warning('using pessimistic values for didHumanResponse');
        for i=1:length(ind)
            trialRecords(ind(i)).didHumanResponse = 1;
        end
    end
    humanResponse = [trialRecords.didHumanResponse];
else 
    warnStatus = true;
end
allHumanResponse = [compiledRecords.compiledTrialRecords.didHumanResponse(trialsFromCRToBeIncluded) humanResponse];

if warnStatus
    warning(['checkCriterion found trialRecords of the older format. some necessary fields are missing. ensure presence of ' ...
    '''containedForcedRewards'',''didStochasticResponse'' and ''didHumanResponse'' in trialRecords to remove this warning']);
end

trialsThisStep=allStepNums==allStepNums(end);

which= trialsThisStep & ~stochastic & ~humanResponse & ~forcedRewards;
which= trialsThisStep & ~stochastic & ~forcedRewards;

% modified to allow human responses to count towards graduation (performanceCriterion)
% which= trialsThisStep & ~stochastic & ~forcedRewards;

[graduate whichCriteria correct]=aboveThresholdPerformance(c.consecutiveTrials,c.pctCorrect,trialRecords(which));

%play graduation tone
if graduate
    beep;
    pause(.2);
    beep;
    pause(.2);
    beep;

    if (nargout > 1)
        details.date = now;
        details.criteria = c;
        details.graduatedFrom = stepNum;
        details.allowedGraduationTo = stepNum + 1;
        details.correct = correct;
        details.whichCriteria = whichCriteria;
    end
end