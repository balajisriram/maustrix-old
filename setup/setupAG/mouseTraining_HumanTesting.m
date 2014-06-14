function r = mouseTraining_HumanTesting(r,subjIDs)
%% This protocol enables the following tasks:
% 1. stochastic free drinks
% 2. earned free drinks
% 3. object recognition 1
% 4. 45 and -45 degrees orientation task

% details for each subject are internally modifiable. 
% define subjects

ValidTestSubject={'demo1','999'};

% define ratrix version to use
svnRev={''};
svnCheckMode='none';

for i=1:length(subjIDs)
    % create the trial steps
    [fd_sto, fd] = createFreeDrinksStepsAG_autoHuman(svnRev,svnCheckMode, subjIDs{i});
    
    [ts_obj1] = createObjectTrialSteps_autoHuman(svnRev,svnCheckMode,subjIDs{i});
    
    [or_optim, or_sfSweep, or_tfSweep, or_ctrSweep, or_orSweep] = createOrientationSteps_autoHuman(svnRev,svnCheckMode,subjIDs{i});

    %%%%%%%%%%% FINALLY make a protocol and put rats on it %%%%%%%%%%%%%%%%%
    
    % here is the protocol
    descriptiveString='mouseTraining_OD';
    pMouseTraining_OD = protocol(descriptiveString,{fd_sto,fd,ts_obj1,or_optim,or_sfSweep,or_tfSweep,or_ctrSweep,or_orSweep,...
        });

    
    %%%%%%%%%%%%
    thisIsANewProtocol=1; % typically 1
    thisIsANewTrainingStep=1; % typically 1
    thisIsANewStepNum=1;  %  typically 1
    
    stepNum = 1;
    if ~ismember(subjIDs{i},ValidTestSubject)
        [correctBox, whichBox] = correctBoxForSubject(subjIDs{i});
        if ~correctBox
            error('you are putting this subject in an unauthorized box. use the correct box num %d',whichBox);
        end
    end
    subjObj = getSubjectFromID(r,subjIDs{i});
    
    [subjObj, r]=setProtocolAndStep(subjObj,pMouseTrainingAG07202012,...
        thisIsANewProtocol,thisIsANewTrainingStep,thisIsANewStepNum,stepNum,...
        r, descriptiveString,'bas');

end
end
