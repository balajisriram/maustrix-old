function [ts_Moptim, ts_Moptim1, ts_Moptim2, ts_Moptim3, ts_Moptim4, ts_MCohSweep] = createMotionSteps_auto(svnRev,svnCheckMode, subID)

out = getStepDetails();

out = getStimAndRewardParams(out,subID);

afc_optim = coherentDots(out.screen_width,out.screen_height,out.num_dotsOpt,...  
    out.coherenceOpt,out.speedOpt,out.contrast,out.dot_sizeOpt,...  
    out.movie_duration,out.screen_zoom,out.maxWidth,out.maxHeight,out.percentCorrectionTrials);

afc_optim1 = coherentDots(out.screen_width,out.screen_height,out.num_dotsOpt,...  
    out.coherenceOpt1,out.speedOpt,out.contrast,out.dot_sizeOpt,...  
    out.movie_duration,out.screen_zoom,out.maxWidth,out.maxHeight,out.percentCorrectionTrials);

afc_optim2 = coherentDots(out.screen_width,out.screen_height,out.num_dotsOpt,...  
    out.coherenceOpt2,out.speedOpt,out.contrast,out.dot_sizeOpt,...  
    out.movie_duration,out.screen_zoom,out.maxWidth,out.maxHeight,out.percentCorrectionTrials);

afc_optim3 = coherentDots(out.screen_width,out.screen_height,out.num_dotsOpt,...  
    out.coherenceOpt3,out.speedOpt,out.contrast,out.dot_sizeOpt,...  
    out.movie_duration,out.screen_zoom,out.maxWidth,out.maxHeight,out.percentCorrectionTrials);

afc_optim4 = coherentDots(out.screen_width,out.screen_height,out.num_dotsOpt,...  
    out.coherenceOpt4,out.speedOpt,out.contrast,out.dot_sizeOpt,...  
    out.movie_duration,out.screen_zoom,out.maxWidth,out.maxHeight,out.percentCorrectionTrials);

afc_cohSweep = coherentDots(out.screen_width,out.screen_height,out.num_dotsOpt,...  
    out.coherenceSweep,out.speedOpt,out.contrast,out.dot_sizeOpt,...  
    out.movie_duration,out.screen_zoom,out.maxWidth,out.maxHeight,out.percentCorrectionTrials);

% sound Manager
sm=makeStandardSoundManager();
% scheduler
sch=noTimeOff(); % runs until swapper ends session

% % criterion
% thresholdPC=performanceCriterionLatestStreak(0.8,int16(200));
% numTrialsCrit_cohSweep = numTrialsDoneCriterion(1600); % 1600 trials = 8 conditions * 200 trials/condition
% numTrialsCrit_velSweep = numTrialsDoneCriterion(1000); % 1000 trials = 5 conditions * 200 trials/condition
% numTrialsCrit_sizeSweep = numTrialsDoneCriterion(200); % 200 trials = 1 conditions * 200 trials/condition

% reinf
rewardScalar = out.rewardScalar;
requestRewardSize = 0;
rewardSize = out.rewardSize;
doAllRequests =	'first'; 
fractionSoundOn = 1; % this applies to beeps
fractionPenaltySoundOn = 0.10;  % fraction of the timeout that annoying error sound is on
msAirpuff = 0;
msPenalty = out.msPenalty;

percentCorrectionTrials = 0.5;

constantRewards=constantReinforcement(rewardSize,requestRewardSize,doAllRequests,msPenalty,fractionSoundOn,fractionPenaltySoundOn,rewardScalar,msAirpuff);
constantRewardsWithReqRewards = constantReinforcement(rewardSize,10,doAllRequests,msPenalty,fractionSoundOn,fractionPenaltySoundOn,rewardScalar,msAirpuff);
tm= nAFC(sm, percentCorrectionTrials, constantRewards);
tmWithReqRew = nAFC(sm, percentCorrectionTrials, constantRewardsWithReqRewards);
% training step using other objects as passed in
ts_Moptim = trainingStep(tmWithReqRew, afc_optim, repeatIndefinitely, sch, svnRev, svnCheckMode,'OptM'); %CHANGE
ts_Moptim1 = trainingStep(tm, afc_optim1, repeatIndefinitely, sch, svnRev, svnCheckMode,'OptM1'); %CHANGE
ts_Moptim2 = trainingStep(tm, afc_optim2, repeatIndefinitely, sch, svnRev, svnCheckMode,'OptM2');% CHANGE
ts_Moptim3 = trainingStep(tm, afc_optim3, repeatIndefinitely, sch, svnRev, svnCheckMode,'OptM3'); %CHANGE
ts_Moptim4 = trainingStep(tm, afc_optim4, repeatIndefinitely, sch, svnRev, svnCheckMode,'OptM4'); %CHANGE
ts_MCohSweep = trainingStep(tm, afc_cohSweep, repeatIndefinitely, sch, svnRev, svnCheckMode,'cohSweep'); %CHANGE
end

function out = getStepDetails()
out.coherenceOpt = {[.99,.80],'selectFrom'};             % Percent of dots to move in a specified direction
out.coherenceOpt1 = {[.99,.80,.60],'selectFrom'};             % Percent of dots to move in a specified direction
out.coherenceOpt2 = {[.99,.80,.60,.40],'selectFrom'};             % Percent of dots to move in a specified direction
out.coherenceOpt3 = {[.99,.80,.60,.40,.20],'selectFrom'};             % Percent of dots to move in a specified direction
out.coherenceOpt4 = {[.99,.80,.60,.40,.20,0],'selectFrom'};             % Percent of dots to move in a specified direction
out.coherenceSweep = {[.15,.2,.25,.3,.35,.4,.65,.9], 'selectFrom'};             % Percent of dots to move in a specified direction
out.contrast = 1;               % contrast of the dots
out.movie_duration = 2;         % in seconds
out.pctCorrectionTrials=.5;
out.replayMode='loop';
out.LUT=[];
out.LUTbits=0;

[a, b] = getMACaddress();
switch b
    case {'A41F7278B4DE','A41F729213E2','A41F726EC11C','7845C4256F4C','7845C42558DF'}%gLab-Behavior1-5
        out.pctCorrectionTrials=.05;
        out.screen_width = 128;         % for matrix
        out.screen_height = 72;        % for matrix
        out.num_dotsOpt = 25;              % Number of dots to display
        out.num_dots1 = 1844;              % Number of dots to display
        out.num_dots2 = 461;              % Number of dots to display
        out.num_dots3 = 115;              % Number of dots to display
        out.speedOpt = 4;                  % How fast do our little dots move
        out.speedSweep = {[0.0825,0.0165,0.33,0.66,1.32], 'selectFrom'};                  % How fast do our little dots move
        out.dot_sizeOpt = 8;              % Width of dots in pixels
        out.dot_size1 = 1;              % Width of dots in pixels
        out.dot_size2 = 2;              % Width of dots in pixels
        out.dot_size3 = 4;              % Width of dots in pixels
        out.screen_zoom=[15 15];
        out.maxWidth = 1920;
        out.maxHeight = 1080;
    case 'A41F729211B1' %gLab-Behavior6
        out.screen_width = 320;         % for matrix
        out.screen_height = 180;        % for matrix
        out.num_dotsOpt = 25;              % Number of dots to display
        out.num_dots1 = 1280;              % Number of dots to display
        out.num_dots2 = 320;              % Number of dots to display
        out.num_dots3 = 80;              % Number of dots to display
        out.speedOpt = 3;                  % How fast do our little dots move
        out.speedSweep = {[0.25,0.5,1,2,4], 'selectFrom'};                  % How fast do our little dots move
        out.dot_sizeOpt = 18;              % Width of dots in pixels
        out.dot_size1 = 3;              % Width of dots in pixels
        out.dot_size2 = 6;              % Width of dots in pixels
        out.dot_size3 = 12;              % Width of dots in pixels
        out.screen_zoom=[5 5];
        out.maxWidth = 1600;
        out.maxHeight = 900;
    case 'BC305BD38BFB' %ephys-stim
        out.screen_width = 128;         % for matrix
        out.screen_height = 72;        % for matrix
        out.num_dotsOpt = 461;              % Number of dots to display
        out.num_dots1 = 1844;              % Number of dots to display
        out.num_dots2 = 461;              % Number of dots to display
        out.num_dots3 = 115;              % Number of dots to display
        out.speedOpt = 0.33;                  % How fast do our little dots move
        out.speedSweep = {[0.0825,0.0165,0.33,0.66,1.32], 'selectFrom'};                  % How fast do our little dots move
        out.dot_sizeOpt = 2;              % Width of dots in pixels
        out.dot_size1 = 1;              % Width of dots in pixels
        out.dot_size2 = 2;              % Width of dots in pixels
        out.dot_size3 = 4;              % Width of dots in pixels
        out.screen_zoom=[15 15];
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
out.percentCorrectionTrials = 0.5;

% details for reinforcement
out.rewardScalar = 0.2;
out.rewardSize = 50;
out.msPenalty = 5000;

end
