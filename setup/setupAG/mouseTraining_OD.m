function r = mouseTraining_OD(r,subjIDs)
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
    [fd_sto, fd] = createFreeDrinksStepsAG_auto(svnRev,svnCheckMode);
    
    [ts_obj1] = createObjectTrialSteps_auto(svnRev,svnCheckMode);
    
    [or_optim, or_sfSweep, or_tfSweep, or_ctrSweep, or_orSweep] = createOrientationSteps_auto(svnRev,svnCheckMode);

    %%%%%%%%%%% FINALLY make a protocol and put rats on it %%%%%%%%%%%%%%%%%
    
    % here is the protocol
    descriptiveString='mouseTraining_OD';
    pMouseTraining_OD = protocol(descriptiveString,{fd_sto,fd,ts_obj1,or_optim,or_sfSweep,or_tfSweep,or_ctrSweep,or_orSweep,...
        });

    
    %%%%%%%%%%%%
    thisIsANewProtocol=1; % typically 1
    thisIsANewTrainingStep=1; % typically 1
    thisIsANewStepNum=1;  %  typically 1
    
    stepNum = getStepNum(subjIDs{i});
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

function [correctBox, whichBox] = correctBoxForSubject(subjID)
Box1Subjects = {'205','209','210','223','225','229'}; % 87 found dead 11/27, '224' f.d.
Box2Subjects = {'216','60','92','66','98','230'}; % 60 gone for inj,'64' sacced
Box3Subjects = {'213','202','211','214','227','231'}; % 91 sacced 11/27,'212' f.d.
Box4Subjects = {'226','61','86','65','228','232'}; % '204' sacced, '63' sacced
Box5Subjects = {'95','200','201','215','206','235'}; % '69' f.d., '233' f.d.
Box6Subjects = {'218','220','221','222','234','236'}; %'219' f.d., '217' removed due to low trial numbers
Subjects = {Box1Subjects,Box2Subjects,Box3Subjects,Box4Subjects,Box5Subjects,Box6Subjects};
currSubj = {subjID,subjID,subjID,subjID,subjID,subjID};
whichBox = find(cellfun(@ismember,currSubj,Subjects));
[junk, mac] = getMACaddress();
correctBox = false;
switch mac
    case 'A41F7278B4DE' %gLab-Behavior1
        if whichBox==1
            correctBox = true;
        end
    case 'A41F729213E2' %gLab-Behavior2
        if whichBox==2
            correctBox = true;
        end
    case 'A41F726EC11C' %gLab-Behavior3
        if whichBox==3
            correctBox = true;
        end
    case '7845C4256F4C' %gLab-Behavior4
        if whichBox==4
            correctBox = true;
        end
    case '7845C42558DF' %gLab-Behavior5
        if whichBox==5
            correctBox = true;
        end
    case 'A41F729211B1' %gLab-Behavior6
        if whichBox==6
            correctBox = true;
        end
end
end
