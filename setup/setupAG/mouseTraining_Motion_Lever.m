function pMouseTraining_Motion_Lever = mouseTraining_Motion_Lever()
%% This protocol enables the following tasks:
% 1. stochastic free drinks
% 2. earned free drinks
% 3. object recognition 1

% details for each subject are internally modifiable. 
% define subjects

ValidTestSubject={'demo1','999'};

% define ratrix version to use
svnRev={''};
svnCheckMode='none';

[fd_sto0, fd_sto, ~, fd_Sides, fd_Alt] = createFreeDrinksStepsAG_auto_Lever(svnRev,svnCheckMode);

[ts_obj1, ts_obj2] = createObjectTrialSteps_auto(svnRev,svnCheckMode);

[ts_Moptim, ~, ~, ~, ~, ~] = createMotionSteps_auto(svnRev,svnCheckMode);


%%%%%%%%%%% FINALLY make a protocol and put rats on it %%%%%%%%%%%%%%%%%

% here is the protocol
descriptiveString='mouseTraining_Motion_Lever';
pMouseTraining_Motion_Lever = protocol(descriptiveString,{fd_sto0,fd_sto,fd_Sides,fd_Alt,ts_obj1, ts_obj2, ts_Moptim});
end

