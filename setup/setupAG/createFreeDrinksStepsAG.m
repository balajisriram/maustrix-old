function [stochdrink, freedrink]=createFreeDrinksStepsAG(svnRev,svnCheckMode,subjectID)

out = getStepDetails(subjectID);

% key variables for reinforcement and trial managers
rewardSizeULorMS = out.rewardSizeULorMS;
scalar = out.scalar;
fractionOpenTimeSoundIsOn = 1;
doAllRequests = 'first';

% these should not matter in FD because there are no wrong answers
msPenalty = out.msPenalty;
fractionPenaltySoundIsOn = 1;
msAirpuff = msPenalty;
percentCorrectionTrials = 0.5;
% should not matter because there is no "request" defined

requestRewardSizeULorMS = out.requestRewardSizeULorMS;

% TO DO low priority: once the FD steps are tested and work, try setting
% all the ones that don't matter to [] and see if it still works.

sm=soundManager({soundClip('correctSound','allOctaves',[400],20000), ...
    soundClip('keepGoingSound','empty'), ...
    soundClip('trySomethingElseSound','gaussianWhiteNoise'), ...
    soundClip('wrongSound','empty'),...
    soundClip('trialStartSound','empty')});

% reinforcement manager
constantRewards=constantReinforcement(rewardSizeULorMS,requestRewardSizeULorMS,doAllRequests,msPenalty,fractionOpenTimeSoundIsOn...
    ,fractionPenaltySoundIsOn,scalar,msAirpuff);


%trialManager
allowRepeats=false;
pStochastic=out.pStochastic;
fd_sto = freeDrinks(sm,pStochastic,allowRepeats,constantRewards);

pStochastic=0;
fd = freeDrinks(sm,pStochastic,allowRepeats,constantRewards);

% stimManager Details
pixPerCycs = out.PPC;
targetOrientations = pi/2;
distractorOrientations = [];
mean = .5;
radius = .1;
contrasts = [1 .5];
thresh = .00005;
yPosPct = .65;

[a, b] = getMACaddress();
switch b
    case '001D7DA80EC2' %gLab-Behavior1
        maxWidth = 1024;
        maxHeight = 768;
    case '001D7DA80EFC' %gLab-Behavior2
        maxWidth = 1024;
        maxHeight = 768;
    case 'A41F726EC11C' %gLab-Behavior3
        maxWidth = 1024;
        maxHeight = 768;
    case '7845C4256F4C' %gLab-Behavior4
        maxWidth = 1920;
        maxHeight = 1080;
    case '7845C42558DF' %gLab-Behavior5
        maxWidth = 1920;
        maxHeight = 1080;
    case 'BC305BD38BFB' %ephys-stim
        maxWidth = 1920;
        maxHeight = 1080;
    case '180373337162' %ephys-data
        maxWidth = 1920;
        maxHeight = 1080;
    otherwise
        a
        b
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

scaleFactor = [1 1];
interTrialLuminance  = .5;

freeStim = orientedGabors(pixPerCycs,targetOrientations,distractorOrientations,mean,radius,contrasts,thresh,yPosPct,maxWidth,maxHeight,scaleFactor,interTrialLuminance);
graduationCriterion=performanceCriterion([.1], int16([10])); %10 pct correct for 10 trials in a row?

stochdrink = trainingStep(fd_sto, freeStim, graduationCriterion , noTimeOff(), svnRev, svnCheckMode);   %stochastic free drinks
freedrink = trainingStep(fd, freeStim, graduationCriterion , noTimeOff(), svnRev, svnCheckMode);  %free drinks
end

function out = getStepDetails(id)
out.rewardSizeULorMS = 50;
out.scalar = 1;
out.msPenalty = 1000;
out.requestRewardSizeULorMS = 10;
out.pStochastic = 0.004;
out.PPC = 64;
switch id
    case '26'
        % nothing changes here, but might later
    case '37'
        % nothing changes here, but might later
    case '38'
        % nothing changes here, but might later
    case '40'
        % nothing changes here, but might later
    case '41'
        % nothing changes here, but might later
    case '45'
        % nothing changes here, but might later
    case '47'
        % nothing changes here, but might later
    case '48'
        % nothing changes here, but might later
    case '50'
        % nothing changes here, but might later
    case '53'
        % nothing changes here, but might later
    case '56'
        % nothing changes here, but might later
    case '59'
        % nothing changes here, but might later
    case '60'
        % nothing changes here, but might later
    case '61'
        % nothing changes here, but might later
    case '62'
        % nothing changes here, but might later
    case '63'
        % nothing changes here, but might later
    case '64'
        % nothing changes here, but might later
    case '65'
        % nothing changes here, but might later
    case '66'
        % nothing changes here, but might later
    case '67'
        % nothing changes here, but might later
    case '68'
        % nothing changes here, but might later
    case '69'
        % nothing changes here, but might later
    case '70'
        % nothing changes here, but might later
    case '79'
        % nothing changes here, but might later
    case '84'
        % nothing changes here, but might later
    case '86'
        % nothing changes here, but might later
    case '87'
        % nothing changes here, but might later
    case '90'
        % nothing changes here, but might later
    case '91'
        % nothing changes here, but might later
    case '92'
        % nothing changes here, but might later
    case '93'
        % nothing changes here, but might later
    case '95'
        % nothing changes here, but might later
    case '96'
        % nothing changes here, but might later
    case '97'
        % nothing changes here, but might later
    case '98'
        % nothing changes here, but might later
    case '99'
        % nothing changes here, but might later
    case '200'
        % nothing changes here, but might later
    case '201'
        % nothing changes here, but might later
    case '202'
        % nothing changes here, but might later
    case '203'
        % nothing changes here, but might later
    case '204'
        % nothing changes here, but might later
    case '205'
        % nothing changes here, but might later
    case '206'
        % nothing changes here, but might later
    case '207'
        % nothing changes here, but might later
    case '208'
        % nothing changes here, but might later
    case '999'
        % nothing changes here, but might later
    case 'demo1'
        % nothing changes here, but might later
    otherwise
        error('unsupported mouse id. are you sure that the mouse is supposed to be here?')
end
end
