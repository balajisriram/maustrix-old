function r = setProtocol_mouseTraining_AG_01072013(r,subjIDs)
%% This protocol enables the following tasks:
% 1. stochastic free drinks
% 2. earned free drinks
% 3. object recognition 1
% 4. 45 and -45 degrees orientation task
% 5. 45 and -45 degrees spatial freqency sweep
% 6. 45 and -45 degrees temporal frequency sweep
% 7. 45 and -45 degrees contrasts sweep
% 8. 45,35,25,15,5,0,-5,-15,-25,-35,-45 orientation sweep

% 9. -45 and 45 degrees orientation task REVERSAL
% 10. -45 and 45 degrees spatial freqency sweep REVERSAL
% 11. -45 and 45 degrees temporal frequency sweep REVERSAL
% 12. -45 and 45 degrees contrasts sweep REVERSAL
% 13. -45,-35,-25,-15,-5,0,5,15,25,35,45 orientation sweep REVERSAL

% 14. -45 and 45 degrees orientation task HALFRAD
% 15. -45 and 45 degrees spatial freqency sweep HALFRAD
% 16. -45 and 45 degrees temporal frequency sweep HALFRAD
% 17. -45 and 45 degrees contrasts sweep HALFRAD
% 18. -45,-35,-25,-15,-5,0,5,15,25,35,45 orientation sweep HALFRAD

% 19. -45 and 45 degrees orientation task QUATRAD
% 20. -45 and 45 degrees spatial freqency sweep QUATRAD
% 21. -45 and 45 degrees temporal frequency sweep QUATRAD
% 22. -45 and 45 degrees contrasts sweep QUATRAD
% 23. -45,-35,-25,-15,-5,0,5,15,25,35,45 orientation sweep QUATRAD

% 24. -45 and 45 degrees orientation task EIGHTSRAD
% 25. -45 and 45 degrees spatial freqency sweep EIGHTSRAD
% 26. -45 and 45 degrees temporal frequency sweep EIGHTSRAD
% 27. -45 and 45 degrees contrasts sweep EIGHTSRAD
% 28. -45,-35,-25,-15,-5,0,5,15,25,35,45 orientation sweep EIGHTSRAD

% 29. -45 and 45 orientations with oriented surrounds task - contrast sweep
 %30. -45 and 45 orientations with oriented surrounds task - low contrasts
% 31. -45 and 45 orientations with oriented surrounds task - medium contrasts
% 32. -45 and 45 orientations with oriented surrounds task - high contrasts
% 33. -45 and 45 orientations with oriented surrounds task - full contrasts

% details for each subject are internally modifiable. 
% define subjects

MouseTrainingCohort_AG={'10','111','1111','13','118','17','18','19','20','24','27','30','32','42','43','49','56','58','51'... previous animals
    '34','134','35','36','37','39','139','40','41','44','61','62',... box 1
    '22','23','25','45','46','47','50','52','53','60'... box 2
    '26','31','38','48','54','55','57','59','63',... box 3
    };
ValidTestSubject={'demo1','999'};

% define ratrix version to use
svnRev={'svn://132.239.158.177/projects/bsriram/Ratrix/branches/multiTrodeStable'};
svnCheckMode='session';

for i=1:length(subjIDs)
    % create the trial steps
    [fd_sto fd] = createFreeDrinksStepsAG(svnRev,svnCheckMode, subjIDs{i});
    
    [ts_obj1] = createObjectTrialSteps(svnRev,svnCheckMode,subjIDs{i});

    
    [or_optim or_sfSweep or_tfSweep or_ctrSweep or_orSweep] = createOrientationSteps(svnRev,svnCheckMode,subjIDs{i});
    [or_optimRev or_sfSweepRev or_tfSweepRev or_ctrSweepRev or_orSweepRev] = createReversalOrientationSteps(svnRev,svnCheckMode,subjIDs{i});
    [or_optimHR or_sfSweepHR or_tfSweepHR or_ctrSweepHR or_orSweepHR] = createOrientationSteps_halfRad(svnRev,svnCheckMode,subjIDs{i});
    [or_optimQR or_sfSweepQR or_tfSweepQR or_ctrSweepQR or_orSweepQR] = createOrientationSteps_quatRad(svnRev,svnCheckMode,subjIDs{i});
    [or_optimER or_sfSweepER or_tfSweepER or_ctrSweepER or_orSweepER] = createOrientationSteps_eighthsRad(svnRev,svnCheckMode,subjIDs{i});
    [orwos_SurrCtrSweep orwos_SurrLowCtr orwos_SurrMedCtr orwos_SurrHighCtr orwos_SurrFullCtr] = createOrientationWithOrientedSurroundSteps(svnRev,svnCheckMode,subjIDs{i})
    %%%%%%%%%%% FINALLY make a protocol and put rats on it %%%%%%%%%%%%%%%%%
    
    % here is the protocol
    descriptiveString='mouseTraining_AG_01072013';
    pMouseTrainingAG07202012 = protocol(descriptiveString,{fd_sto,fd,or_optim,or_sfSweep,or_tfSweep,or_ctrSweep,or_orSweep,ts_obj1,...
        or_optimRev,or_sfSweepRev,or_tfSweepRev,or_ctrSweepRev,or_orSweepRev,...
        or_optimHR,or_sfSweepHR,or_tfSweepHR,or_ctrSweepHR,or_orSweepHR,...
        or_optimQR,or_sfSweepQR,or_tfSweepQR,or_ctrSweepQR,or_orSweepQR,...
        or_optimER,or_sfSweepER,or_tfSweepER,or_ctrSweepER,or_orSweepER,...
        orwos_SurrCtrSweep,orwos_SurrLowCtr,orwos_SurrMedCtr,orwos_SurrHighCtr,orwos_SurrFullCtr});

    
    %%%%%%%%%%%%
    thisIsANewProtocol=1; % typically 1
    thisIsANewTrainingStep=1; % typically 1
    thisIsANewStepNum=1;  %  typically 1
    
    stepNum = getStepNum(subjIDs{i});
    [correctBox whichBox] = correctBoxForSubject(subjIDs{i},stepNum);
    if ~correctBox
        error('you are putting this subject in an unauthorized box. use the correct box num %d',whichBox);
    end
    subjObj = getSubjectFromID(r,subjIDs{i});
    
    if ismember(subjIDs{i},MouseTrainingCohort_AG) % define ID list at top of this file
        [subjObj r]=setProtocolAndStep(subjObj,pMouseTrainingAG07202012,...
            thisIsANewProtocol,thisIsANewTrainingStep,thisIsANewStepNum,stepNum,...
            r, descriptiveString,'bas');
    elseif ismember(subjIDs{i}, ValidTestSubject),% for testing
        
        [subjObj r]=setProtocolAndStep(subjObj,pMouseTrainingAG07202012,...
            thisIsANewProtocol,thisIsANewTrainingStep,thisIsANewStepNum,stepNum,... % set demoStep at top
            r, descriptiveString,'bas');
    else
        error('unexpected ID')
    end
end
end

function step = getStepNum(id)
switch id
    case '10'
        step = 24;
    case '111'
        step = 29;
    case '134'
        step = 5;    
    case '1111'
        step = 29;    
    case '13'
        step = 4;
    case '17'
        step = 4;
    case '18'
        step = 29;
    case '19'
        step = 24;
    case '20'
        step = 29;
    case '22'
        step = 3;
    case '23'
        step = 3;
    case '24'
        step = 3;
    case '25'
        step = 3;
    case '26'
        step = 2;
    case '27'
        step = 14;
    case '30'
        step = 9;
    case '31'
        step = 29;
    case '32'
        step = 1;
    case '34'
        step = 29;
    case '35'
        step = 6;
    case '36'
        step = 6;
    case '37'
        step = 5;
    case '38'
        step = 19;
    case '39'
        step = 7;    
    case '40'
        step = 7;
    case '41'
        step = 7;
    case '42'
        step = 2;
    case '43'
        step = 8;
    case '44'
        step = 6;
    case '49'
        step = 8;
    case '50'
        step = 3;
    case '51'
        step = 2;
    case '48'
        step = 3;
    case '52'
        step = 1;
    case '53'
        step = 1;
    case '54'
        step = 1;
    case '55'
        step = 1;
    case '56'
        step = 2;
    case '57'
        step = 2;
    case '58'
        step = 1;
    case '59'
        step = 1;    
    case 'demo1'
        step = 7;
    case '139'
        step = 7;
    case '60'
        step = 1;
    case '61'
        step = 1;
    case '62'
        step = 1;
    case '63'
        step = 2;    
    case '118'
        step = 29;    
    case '999'
        step = 29;
    otherwise
        error('unsupported mouse id. are you sure that the mouse is supposed to be here?')
end
end

function [correctBox whichBox] = correctBoxForSubject(subjID,stepNum)
Box1Subjects = {'34','134','35','36','37','39','139','40','41','44','61','62'};
Box2Subjects = {'22','23','25','45','46','47','50','52','53','60'};
Box3Subjects = {'26','31','38','48','54','55','57','59','63'};
Box4Subjects = {};
Box5Subjects = {};
Subjects = {Box1Subjects,Box2Subjects,Box3Subjects,Box4Subjects,Box5Subjects};
currSubj = {subjID,subjID,subjID,subjID,subjID};
whichBox = find(cellfun(@ismember,currSubj,Subjects));
[succ mac] = getMACaddress();
correctBox = false;
switch mac
    case '1' % BOX 1
        if whichBox==1
            correctBox = true;
        elseif (stepNum==1 || stepNum==2)
            correctBox = true;
        end
    case '2' % BOX 2
        if whichBox==2
            correctBox = true;
        elseif (stepNum==1 || stepNum==2)
            correctBox = true;
        end
    case '3' % BOX 3
        if whichBox==3
            correctBox = true;
        elseif (stepNum==1 || stepNum==2)
            correctBox = true;
        end
    case '4' % BOX 4
        if whichBox==4
            correctBox = true;
        elseif (stepNum==1 || stepNum==2)
            correctBox = true;
        end
    case '5' % BOX 5
        if whichBox==5
            correctBox = true;
        elseif (stepNum==1 || stepNum==2)
            correctBox = true;
        end
end
end
