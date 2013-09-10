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
        step = 4; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
        % changed to step 8 for week of 7/8
        % back to optimal for week of 7/15
        error('not being run');
    case '38'
        step = 4; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
        % changed to step 8 for week of 7/8
        % back to optimal for week of 7/15
        error('not being run');
    case '40'
        step = 8; 
        % changed from step 3 on 6/3/2013; actually 40 has a lot of data on step 8. It will continue to run on step 3 for a week.
        % getting data on step 4 for wek of 6/24
        % moved to step 8 week of 7/1
        error('not being run');
    case '41'
        step = 4;
        error('not being run'); % decided on 6/4/2013
    case '45'
        step = 7; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
        % 1 week of step 8 week of 7/15
        % varied contrast week starting 1/8
        % varied orientation week of 12/8
    case '47'
        step = 8;
        % getting more images trials for week of 6/17
        % step 4 for week of 6/24
        % moved to step 8 week of 7/1
        error('not being run');
    case '48'
        step = 4; % changed from step 7 on 6/3/2013
        error('not being run'); % finished week of 6/17
    case '50'
        step = 7; 
        % changed from step 4 6/4
        % changed to step 8 in prep for lesioning. 6/18
        % couple of days of orientation data week of 6/24
        % 1 week of step 8 week of 7/15
        % varied contrast week starting 1/8
        % varied orientation week of 12/8
    case '53'
        step = 8;
        % obtaining more object task trials week of 6/17
        % step 4 for week of 6/24
        % moved to step 8 week of 7/1
        error('not being run');
    case '56'
        step = 4;
        % knows step 3 will go to varied contrast week of 6/17
        % performed ~ 750 trials onstep 6 now on step 7 6/24   
        % moved to step 4 week of 7/1
        error('not being run');
    case '59'
        step = 7;
        % knows step 3. goes to step 6 6/24
        % moved to step 7 week of 7/1
        error('not being run');
    case '60'
        step = 22; 
        % lots of autograduations ! now hard set to 3. 6/5
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
    case '61'
        step = 19;
        % back from the injections. going to run 8/19
        % performed admirably at step 3 for a day. will start on step 19 9/10
    case '62'
        step = 22; 
        % graduated from step 8 to step 3 for 6/6
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
    case '63'
        step = 23; 
        % changed 6/4
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
        % varied orientation with aperture 9/10
    case '64'
        step = 23; 
        % changed to step 3 for 6/10 from step 8
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
        % varied orientation with aperture 9/10
    case '65'
        step = 23; 
        % changed 6/4
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
        % varied orientation with aperture 9/10
    case '66'
        step = 23; 
        % changed protocol for 6/10
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
        % varied orientation with aperture 9/10
    case '67'
        step = 22; 
        % graduated from 8 on 6/5
        % changed from step 3 to step 6 on 6/17
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        error('died on 8/5');
    case '68'
        step = 3;
        error('not being run'); % not doing enough trials, 6/24
    case '69'
        step = 23; 
        % changed 6/4
        % changed from step 3 to step 6 on 6/17
        % moved to varied orientation 
        % varied s.f. week of 7/15
        % small aperture starting 7/31
        % increased aperture size 8/6
        % varied contrast with aperture 8/12
        % varied orientation with aperture 9/10 
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
        step = 19;
        % back with step 8 on 8/1
        % starting on step 3 for a week with pbs inj.
        % aperture on 8/26
    case '87'
        step = 19;
        % back with step 8 on 8/1
        % starting on step 3 for a week with pbs inj.
        % aperture on 8/26
    case '88'
        step = 8;
    case '89'
        step = 8;
    case '90'
        step = 3;
        error('not being run'); % as of 6/22
    case '91'
        step = 19;
        % back with step 8 on 8/1
        % starting on step 3 for a week with pbs inj.
        % aperture on 8/26
    case '92'
        step = 19;
        % back with step 8 on 8/1
        % starting on step 3 for a week with pbs inj.
        % aperture on 8/26
    case '93'
        step = 3;
    case '95'
        step = 3; 
        % force graduate starting on 6/10
        % graduated to step 3 7/22
    case '96'
        step = 3;
        % force graduate starting on 6/10
        % graduated to step 3 7/2
    case '97'
        step = 3;
        % graduated to step 2 6/12
        % graduated to step 8 7/8
        % graduated to step 3 8/19
    case '98'
        step = 3;
        % graduated to step 2 6/12
        % graduated to step 8 on 7/2
        % graduate step 3 on 8/26
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
        % back from injections. starting 8/19
        % all good at step 8. Continue at step 3 8/22
    case '201'
        step = 19;
        % graduated to step 2 6/12
        % gradauted to step 8 6/14
        % graduated to step 3 7/2
        % back from injections. starting 8/19
        % all good at step 8. Continue at step 3 8/22
        % aperture task starting 9/10
    case '202'
        step = 19;
        % graduated to step 2 6/12
        % graduated to step 8 6/21
        % aperture task starting 9/10
    case '203'
        step = 3;
        % graduated to step 2 6/12
        % gradauted to step 8 6/14
        % graduated to step 3 7/2
    case '204'
        step = 3;
        % graduated to step 2 6/12
        % graduated to step 8 6/18
        % graduated to step 3 7/15
    case '205'
        step = 3;
        % graduated to step 2 6/26
        % graduated to step 8 7/8
        % graduate to step 3 8/2
    case '206'
        step = 3;
        % graduated to step 2 6/26
        % graduated to step 8 8/6
        % graduated to step 3 8/26
    case '207'
        step = 3;
        % graduated to step 2 6/26
        % graduated to step 8 7/2
        % graduated to step 3 7/22
    case '208'
        step = 3;
        % graduated to step 2 6/26
        % graduated to step 8 7/8
        % graduated to step 3 on 8/26
    case '209'
        step = 3;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduated to step 3 9/10
    case '210'
        step = 19;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduated to step 3 8/8
        % graduated to step 19 9/10
    case '211'
        step = 19;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduated to step 3 8/12
        % graduated to step 19 9/10
    case '212'
        step = 3;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduated to step 3 9/10
    case '213'
        step = 3;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % gradauted to step 3 on 8/22
    case '214'
        step = 3;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduate to step 3 on 8/22
    case '215'
        step = 3;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduate to step 3 8/25
    case '216'
        step = 19;
        % graduated to step 2 7/8
		% graduated to step 8 7/22
        % graduated to step 3 8/6
        % graduated to step 19 9/10
    case '999'
        step = 3;
    otherwise
        error('unsupported mouse id. are you sure that the mouse is supposed to be here?')
end
end

function [correctBox, whichBox] = correctBoxForSubject(subjID)
Box1Subjects = {'86','87','205','209','210','211','216'};
Box2Subjects = {'60','92','97','98','212'};
Box3Subjects = {'91','99','206','207','208','213','214','215'};
Box4Subjects = {'61','63','64','65','66','203','204'};
Box5Subjects = {'69','79','95','96','200','201','202'};
Subjects = {Box1Subjects,Box2Subjects,Box3Subjects,Box4Subjects,Box5Subjects};
currSubj = {subjID,subjID,subjID,subjID,subjID};
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
end
end
