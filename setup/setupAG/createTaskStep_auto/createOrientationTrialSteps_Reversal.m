function [ts1, ts2]=createOrientationTrialSteps_Reversal(svnRev,svnCheckMode,subID)

% basic details for stim
out.pixPerCycs={[64,128,256],[64,128,256]};

out.driftfrequencies={[0],[0]};

orsSweep = [0,11.25,22.5,33.75,45,-11.5,-22.5,-33.75,-45];
out.orientations={deg2rad(orsSweep),deg2rad(orsSweep)};

out.phases={[0 pi/4 pi/2 3*pi/4 pi],[0 pi/4 pi/2 3*pi/4 pi]};

out.contrasts = {[0.15 1],[0.15,1]};

out.maxDuration = {0.5,0.5};

out.radii={0.25,0.25};
out.annuli={0,0};
out.location1={[.25 .5],[.75 .5]};      % center of mask
out.location2={[.75 .5],[.25 .5]};      % center of mask
out.waveform= 'sine';
out.radiusType='hardEdge';
out.normalizationMethod='normalizeDiagonal';
out.mean=0.5;
out.thresh=.00005;

[a, b] = getMACaddress();
switch b
    case 'A41F7278B4DE' %gLab-Behavior1
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case 'A41F729213E2' %gLab-Behavior2
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case 'A41F726EC11C' %gLab-Behavior3
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case '7845C4256F4C' %gLab-Behavior4
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case '7845C42558DF' %gLab-Behavior5
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case 'A41F729211B1' %gLab-Behavior6
        out.maxWidth = 1600;
        out.maxHeight = 900;
    case 'BC305BD38BFB' %ephys-stim
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case '180373337162' %ephys-data
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    otherwise
        a
        b
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

out.scaleFactor=0;
out.interTrialLuminance=.5;
out.doCombos = true;

% details for reinforcement
out.rewardScalar = 0.2;
out.rewardSize = 50;
out.msPenalty = 5000;
out.doPostDiscrim = true;

out = getStimAndRewardParams(out,subID);


afc_or1 = afcGratings(out.pixPerCycs,out.driftfrequencies,out.orientations,out.phases,out.contrasts,out.maxDuration,...
    out.radii,out.radiusType,out.annuli,out.location1,out.waveform,out.normalizationMethod,out.mean,out.thresh,out.maxWidth,out.maxHeight,...
    out.scaleFactor,out.interTrialLuminance,out.doCombos,out.doPostDiscrim);

afc_or2 = afcGratings(out.pixPerCycs,out.driftfrequencies,out.orientations,out.phases,out.contrasts,out.maxDuration,...
    out.radii,out.radiusType,out.annuli,out.location2,out.waveform,out.normalizationMethod,out.mean,out.thresh,out.maxWidth,out.maxHeight,...
    out.scaleFactor,out.interTrialLuminance,out.doCombos,out.doPostDiscrim);

% reinf
rewardScalar = out.rewardScalar;
requestRewardSize = 0; 
rewardSize = out.rewardSize;
doAllRequests =	'first'; 
fractionSoundOn = 1; % this applies to beeps
fractionPenaltySoundOn = 0.10;  % fraction of the timeout that annoying error sound is on
msAirpuff = 0;
msPenalty = out.msPenalty;

percentCorrectionTrials = 0.2;

% sound Manager
sm=makeStandardSoundManager();
% scheduler
sch=noTimeOff(); % runs until swapper ends session
constantRewards=constantReinforcement(rewardSize,requestRewardSize,doAllRequests,...
    msPenalty,fractionSoundOn,fractionPenaltySoundOn,rewardScalar,msAirpuff);  %% rewardScalar, msPenalty are arguments to the function
tm= nAFC(sm, percentCorrectionTrials, constantRewards); %percentCorrectionTrials is an argument to the function


% criterion
thresholdPC=performanceCriterionLatestStreak([0.75],int16([200]));


ts1 = trainingStep(tm, afc_or1, thresholdPC, sch,svnRev,svnCheckMode,'GotoObject_FullC');
ts2 = trainingStep(tm, afc_or2, thresholdPC, sch,svnRev,svnCheckMode,'GoAwayFromObject_FullC');
end
