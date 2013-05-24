function [ts_obj1 ts_obj2]=createObjectTrialSteps(svnRev,svnCheckMode,subjectID)

out = getStepDetails(subjectID);


%utilities function: standard stuff for all nAFC training steps
rewardScalar = out.rewardScalar;
msPenalty = out.msPenalty;
percentCorrectionTrials=0.3;

sm=soundManager({soundClip('correctSound','allOctaves',[400],20000), ...
    soundClip('keepGoingSound','empty'), ...
    soundClip('trySomethingElseSound','gaussianWhiteNoise'), ...
    soundClip('wrongSound','empty'),...
    soundClip('trialStartSound','empty')});

% scheduer 
sch=noTimeOff(); % runs until swapper ends session

% graduation criteria for graduation
easy_pc=performanceCriterion([0.8],int16([200]));
strict_pc=performanceCriterion([0.85, 0.8],int16([200, 500]));
 
% take reinforcement manager from setProtocolTest but with params from Pam
requestRewardSize   =	0; 
rewardSize          =   out.rewardSize; % try this, may need to increase water rwd
doAllRequests       =	'first'; % always do this
fractionSoundOn     =	1; % this applies to beeps
fractionPenaltySoundOn = 0.10;  % fraction of the timeout that annoying error sound is on
msAirpuff           =   0;

constantRewards=constantReinforcement(rewardSize,requestRewardSize,doAllRequests,...
    msPenalty,fractionSoundOn,fractionPenaltySoundOn,rewardScalar,msAirpuff);  %% rewardScalar, msPenalty are arguments to the function

%create a trial manager - 
tm= nAFC(sm, percentCorrectionTrials, constantRewards); %percentCorrectionTrials is an argument to the function


%%%%%%% OBJECT RECOGNITION COMPONENT %%%%%%%%%%%%%%%%%%%
%parameters used for all object rec steps:
% vary size and rotation very slightly
imageRotation=[-20 20]; imageSize=[.75 1];

try 
    imdir = '\\ghosh-16-159-221.ucsd.edu\ghosh\imFiles\PRimageset';
catch ex
    sca;
    keyboard;
end

imagelist = struct;
% contains nike and blank, nike is target
imagelist.level1 ={ { {'Nike_standardcontrast' 'blank'} 1.0} };
%  contains nike and a mirror image of discobolus (better match of overall shape); 
%  in this task nike is target
imagelist.level2 ={ { {'Nike_standardcontrast' 'DiscobolusMirror2_standardcontrast' } 1.0} }; %
% this is for our white noise oriented stim
imagelist.level3 ={ { {'Right45Lg' 'blank'} 1.0} };  
% with distractor
imagelist.level4 ={ { {'Right45Lg' 'Left45Lg'} 1.0} }; % populate struct, each training step has a field for its list


interTrialLuminance_nAFC = 0.3; %extremely brief during stim calculation
background_nAFC=0; % note must be 0
ypos_nAFC=0; %location of image stimuli is near ports
imageSelectionMode='normal'; % not deck
imageSizeYoked=false; %true; % images have same size
imageRotationYoked=false; % rotation of two images chosen independently
drawingMode='expert';

[a,b] = getMACaddress();
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
    case '7845C42558D4' %gLab-Behavior5
        maxWidth = 1920;
        maxHeight = 1080;
    case 'BC305BD38BFB' %ephys-stim
        maxWidth = 1920;
        maxHeight = 1080;
    case '180373337162' %ephys-data
        maxWidth = 1920;
        maxHeight = 1080;
    otherwise
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

scaleFactor             =[1 1]; %show image at full size
percentCorrectionTrials = 0.5;

% step 4 = go to S+
%create stim manager here
imlist=imagelist.level1; % go to nike not blank
imagestim = images(imdir,ypos_nAFC, background_nAFC,...
    maxWidth,maxHeight,scaleFactor,interTrialLuminance_nAFC, imlist,...
    imageSelectionMode,imageSize,imageSizeYoked,imageRotation,imageRotationYoked,...
    percentCorrectionTrials,drawingMode);
ts_obj1 = trainingStep(tm, imagestim, easy_pc, sch,svnRev,svnCheckMode);

% % step 5 = go to S+ ignore S- (try discobolos, mirror imaged)
% step 4 = go to S+
%create stim manager here
imlist=imagelist.level2; % go to nike not blank
imagestim = images(imdir,ypos_nAFC, background_nAFC,...
    maxWidth,maxHeight,scaleFactor,interTrialLuminance_nAFC, imlist,...
    imageSelectionMode,imageSize,imageSizeYoked,imageRotation,imageRotationYoked,...
    percentCorrectionTrials,drawingMode);
ts_obj2 = trainingStep(tm, imagestim, easy_pc, sch,svnRev,svnCheckMode);
end

function out = getStepDetails(id)
out.rewardScalar = 0.25;
out.msPenalty = 12000;
out.rewardSize = 50;
switch id
    case '999'
        % nothing changes here, but might later
    case 'demo1'
        out.maxDurationOpt = {[3],[3]};
        out.doPostDiscrim = true;
    otherwise
        error('unsupported mouse id. are you sure that the mouse is supposed to be here?')
end
end
