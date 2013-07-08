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

ValidTestSubject={'demo1','999'};

% define ratrix version to use
svnRev={''};
svnCheckMode='none';

for i=1:length(subjIDs)
    % create the trial steps
    [fd_sto, fd] = createFreeDrinksStepsAG(svnRev,svnCheckMode, subjIDs{i});
    
    [ts_obj1] = createObjectTrialSteps(svnRev,svnCheckMode,subjIDs{i});

    
    [or_optim, or_sfSweep, or_tfSweep, or_ctrSweep, or_orSweep] = createOrientationSteps(svnRev,svnCheckMode,subjIDs{i});
    [or_optimRev, or_sfSweepRev, or_tfSweepRev, or_ctrSweepRev, or_orSweepRev] = createReversalOrientationSteps(svnRev,svnCheckMode,subjIDs{i});
    [or_optimHR, or_sfSweepHR, or_tfSweepHR, or_ctrSweepHR, or_orSweepHR] = createOrientationSteps_halfRad(svnRev,svnCheckMode,subjIDs{i});
    [or_optimQR, or_sfSweepQR, or_tfSweepQR, or_ctrSweepQR, or_orSweepQR] = createOrientationSteps_quatRad(svnRev,svnCheckMode,subjIDs{i});
    [or_optimER, or_sfSweepER, or_tfSweepER, or_ctrSweepER, or_orSweepER] = createOrientationSteps_eighthsRad(svnRev,svnCheckMode,subjIDs{i});
    [orwos_SurrCtrSweep, orwos_SurrLowCtr, orwos_SurrMedCtr, orwos_SurrHighCtr, orwos_SurrFullCtr] = createOrientationWithOrientedSurroundSteps(svnRev,svnCheckMode,subjIDs{i});
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

function step = getStepNum(id)
switch id
    case '26'
        step = 10;
        error('not being run'); % changed on 6/24
        % changed from step 8 on 6/3/2013
        % changed from rev on 6/17
    case '37'
        step = 8; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
        % changed to step 8 for week of 7/8
    case '38'
        step = 8; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
        % changed to step 8 for week of 7/8
    case '40'
        step = 8; 
        % changed from step 3 on 6/3/2013; actually 40 has a lot of data on step 8. It will continue to run on step 3 for a week.
        % getting data on step 4 for wek of 6/24
        % moved to step 8 week of 7/1
    case '41'
        step = 4;
        error('not being run'); % decided on 6/4/2013
    case '45'
        step = 3; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
    case '47'
        step = 8;
        % getting more images trials for week of 6/17
        % step 4 for week of 6/24
        % moved to step 8 week of 7/1
    case '48'
        step = 4; % changed from step 7 on 6/3/2013
        error('not being run'); % finished week of 6/17
    case '50'
        step = 3; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
    case '53'
        step = 8;
        % obtaining more object task trials week of 6/17
        % step 4 for week of 6/24
        % moved to step 8 week of 7/1
    case '56'
        step = 4;
        % knows step 3 will go to varied contrast week of 6/17
        % performed ~ 750 trials onstep 6 now on step 7 6/24   
        % moved to step 4 week of 7/1
    case '59'
        step = 7;
        % knows step 3. goes to step 6 6/24
        % moved to step 7 week of 7/1
    case '60'
        step = 7; 
        % lots of autograduations ! now hard set to 3. 6/5
        % changed from step 3 to step 6 on 6/17
    case '61'
        step = 3;
    case '62'
        step = 7; 
        % graduated from step 8 to step 3 for 6/6
        % changed from step 3 to step 6 on 6/17
    case '63'
        step = 7; 
        % changed 6/4
        % changed from step 3 to step 6 on 6/17
    case '64'
        step = 7; 
        % changed to step 3 for 6/10 from step 8
        % changed from step 3 to step 6 on 6/17
    case '65'
        step = 7; 
        % changed 6/4
        % changed from step 3 to step 6 on 6/17
    case '66'
        step = 7; 
        % changed protocol for 6/10
        % changed from step 3 to step 6 on 6/17
    case '67'
        step = 7; 
        % graduated from 8 on 6/5
        % changed from step 3 to step 6 on 6/17
    case '68'
        step = 3;
        error('not being run'); % not doing enough trials, 6/24
    case '69'
        step = 7; 
        % changed 6/4
        % changed from step 3 to step 6 on 6/17
        % moved to varied orientation 
    case '70'
        step = 3;
        error('not being run'); % poor performer and not doing enough trials 6/24
    case '79'
        step = 3;
        % graduated to step 3 on 6/19
    case '84'
        step = 3;
        error('not being run'); % as of 6/22
    case '86'
        step = 3;
    case '87'
        step = 3;
    case '88'
        step = 8;
    case '89'
        step = 8;
    case '90'
        step = 3;
        error('not being run'); % as of 6/22
    case '91'
        step = 3;
    case '92'
        step = 3;
    case '93'
        step = 3;
    case '95'
        step = 8; 
        % force graduate starting on 6/10
    case '96'
        step = 3;
        % force graduate starting on 6/10
        % graduated to step 3 7/2
    case '97'
        step = 8;
        % graduated to step 2 6/12
        % graduated to step 8 7/8
    case '98'
        step = 8;
        % graduated to step 2 6/12
        % graduated to step 8 on 7/2
    case '99'
        step = 3;
        % graduated to step 2 6/12
        % graduated to step 8 6/18
        % graduated to step 3 7/8
    case '200'
        step = 3;
        % graduated to step 2 6/12
        % gradauted to step 8 6/14
        % graduated to step 3 7/2
    case '201'
        step = 3;
        % graduated to step 2 6/12
        % gradauted to step 8 6/14
        % graduated to step 3 7/2
    case '202'
        step = 8;
        % graduated to step 2 6/12
        % graduated to step 8 6/21
    case '203'
        step = 3;
        % graduated to step 2 6/12
        % gradauted to step 8 6/14
        % graduated to step 3 7/2
    case '204'
        step = 8;
        % graduated to step 2 6/12
        % graduated to step 8 6/18
    case '205'
        step = 8;
        % graduated to step 2 6/26
        % graduated to step 8 7/8
    case '206'
        step = 2;
        % graduated to step 2 6/26
    case '207'
        step = 8;
        % graduated to step 2 6/26
        % graduated to step 8 7/2
    case '208'
        step = 8;
        % graduated to step 2 6/26
        % graduated to step 8 7/8
    case '209'
        step = 2;
        % graduated to step 2 7/8
    case '210'
        step = 2;
        % graduated to step 2 7/8
    case '211'
        step = 2;
        % graduated to step 2 7/8
    case '212'
        step = 2;
        % graduated to step 2 7/8
    case '213'
        step = 2;
        % graduated to step 2 7/8
    case '214'
        step = 2;
        % graduated to step 2 7/8
    case '215'
        step = 2;
        % graduated to step 2 7/8
    case '216'
        step = 2;
        % graduated to step 2 7/8
    case '999'
        step = 3;
    otherwise
        error('unsupported mouse id. are you sure that the mouse is supposed to be here?')
end
end

function [correctBox, whichBox] = correctBoxForSubject(subjID)
Box1Subjects = {'37','38','40','56','60','86','87','205','206'};
Box2Subjects = {'45','47','50','53','92','97','98','209','210','211','212'};
Box3Subjects = {'91','93','59','99','207','208','213','214','215','216'};
Box4Subjects = {'61','62','63','64','65','66','67','88','89','203','204'};
Box5Subjects = {'69','70','79','95','96','200','201','202'};
Subjects = {Box1Subjects,Box2Subjects,Box3Subjects,Box4Subjects,Box5Subjects};
currSubj = {subjID,subjID,subjID,subjID,subjID};
whichBox = find(cellfun(@ismember,currSubj,Subjects));
[junk, mac] = getMACaddress();
correctBox = false;
switch mac
    case '001D7DA80EC2' %gLab-Behavior1
        if whichBox==1
            correctBox = true;
        end
    case '001D7DA80EFC' %gLab-Behavior2
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
end
end
