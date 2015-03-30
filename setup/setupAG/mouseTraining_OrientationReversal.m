function pMouseTraining_OrientationReversal = mouseTraining_OrientationReversal(subjIDs)
%% This protocol enables the following tasks:
% 1. object recognition 1: go to the object
% 2. object recognition 2: go away from object

% details for each subject are internally modifiable. 
% define subjects

ValidTestSubject={'demo1','999'};

% define ratrix version to use
svnRev={''};
svnCheckMode='none';

[ts_or1, ts_or2] = createOrientationTrialSteps_Reversal(svnRev,svnCheckMode,subjIDs);

% here is the protocol
descriptiveString='mouseTraining_OrientationReversal';
loopedProtocol = true;
pMouseTraining_OrientationReversal = protocol(descriptiveString,{ts_or1,ts_or2},loopedProtocol);
end