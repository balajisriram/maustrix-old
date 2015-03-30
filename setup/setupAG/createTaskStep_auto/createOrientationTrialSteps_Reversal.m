function [ts1, ts2]=createOrientationTrialSteps_Reversal(svnRev,svnCheckMode,subID)

% basic details for stim
out.pixPerCycs={[16,32,64,128,256],[16,32,64,128,256]};

out.driftfrequencies={[0],[0]};

orsSweep = [0,11.25,22.5,33.75,45,-11.5,-22.5,-33.75,-45];
out.orientations={deg2rad(orsSweep),deg2rad(orsSweep)};

out.phases={[0 pi/4 pi/2 3*pi/4 pi],[0 pi/4 pi/2 3*pi/4 pi]};

out.contrasts = {[0.15 1],[0.15,1]};

out.maxDuration = {0.25,0.25};

out.radii={0.1,0.1};
out.annuli={0,0};
out.location1={[.2 .5],[.8 .5]};      % center of mask
out.location2={[.8 .5],[.2 .5]};      % center of mask
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
out.doPostDiscrim = false;
out.doPostDiscrimDurSweep = true;


out = getStimAndRewardParams(out,subID);


afc_or1 = afcGratings(out.pixPerCycs,out.driftfrequencies,out.orientations,out.phases,out.contrasts,out.maxDuration,...
    out.radii,out.radiusType,out.annuli,out.location1,out.waveform,out.normalizationMethod,out.mean,out.thresh,out.maxWidth,out.maxHeight,...
    out.scaleFactor,out.interTrialLuminance,out.doCombos,out.doPostDiscrim);

afc_or2 = afcGratings(out.pixPerCycs,out.driftfrequencies,out.orientations,out.phases,out.contrasts,out.maxDuration,...
    out.radii,out.radiusType,out.annuli,out.location2,out.waveform,out.normalizationMethod,out.mean,out.thresh,out.maxWidth,out.maxHeight,...
    out.scaleFactor,out.interTrialLuminance,out.doCombos,out.doPostDiscrim);


ts1 = trainingStep(tm, imagestim1, thresholdPC, sch,svnRev,svnCheckMode,'GotoObject_FullC');
ts2 = trainingStep(tm, imagestim2, thresholdPC, sch,svnRev,svnCheckMode,'GoAwayFromObject_FullC');
end
