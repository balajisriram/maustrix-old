function pMouseTraining_Init = mouseTraining_Init(subID)
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

[fd_sto, fd] = createFreeDrinksStepsAG_auto(svnRev,svnCheckMode,subID);

[ts_obj1] = createObjectTrialSteps_auto(svnRev,svnCheckMode,subID);

%%%%%%%%%%% FINALLY make a protocol and put rats on it %%%%%%%%%%%%%%%%%

% here is the protocol
descriptiveString='mouseTraining_Init';
pMouseTraining_Init = protocol(descriptiveString,{fd_sto,fd,ts_obj1});
end

