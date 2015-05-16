function changeParamsForSubject

dataPath=fullfile(fileparts(fileparts(getRatrixPath)),'ratrixData',filesep);
defaultLoc=fullfile(dataPath, 'ServerData');

d=dir(fullfile(defaultLoc, 'db.mat'));

if length(d)==1
    rx=ratrix(defaultLoc,0);
    fprintf('loaded ratrix from default location\n')
else
    error('you are doing something dangerous - are you sure you know what you are doing?');
end

try
    [success, mac]=getMACaddress();
    if ~success
        mac='000000000000';
    end
catch
    mac='000000000000';
end

pOD = @mouseTraining_OD;
pODSweeps = @mouseTraining_ODSweeps;
pMotion = @mouseTraining_Motion;
pReversal = @mouseTraining_ObjectReversal;
pOrReversal = @mouseTraining_OrientationReversal;
pMotion_Lever = @mouseTraining_Motion_Lever;
pInit = @mouseTraining_Init;
switch mac
    case 'A41F7278B4DE' %gLab-Behavior1
%         subjectID = '223';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 8;
%         [~, rx]=setProtocolAndStep(sub,pOD('223'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed protocol to variedDur and to step 5 on 7/29
%         % sent back to ctrVarDur 11/2
%         % changed to varied duration easy duration 11/16
% 
%         subjectID = '251';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('251'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.25 9/13
%         % sent to OD task and reduced reward to 0.1 9/22
%         % increased timeout to 15000 10/7
%         
%         subjectID = '252';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('252'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.25 9/13
%         % sent to OD task and reduced reward to 0.1 9/22
%         % increased penalty to 15000 10/7
%         % reduced reward to 0.05 10/10
%         % increased reward to 0.1 11/2
%         % increased penalty to 20s
%         % increased reward and increased timeout 2/2
%         
%         subjectID = '241';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5; % back to learning the task 10-29
%         [~, rx]=setProtocolAndStep(sub,pMotion('241'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         % change % corr trials, and dot size/number 9/3
%         % reduced reward to 0.25 9/13
%         % sent back to the original task 10/29
%         % increased reward to 0.35 and increased penalty to 20000 for
%         % improved performance 12/20
%         % reduced reward (0.25) and reduced timeout(10000) 2/2
%         % moved animal to varied coherence on 3/22
%         % back to learning 3/29
%         % moved to more varied coherence
%         % animals are shit!! 4/20
%         
%         subjectID = '246';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 9;
%         [~, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         % degraduated to step 3 9/13
%         % sent to pOD (was on pOD earlier but has new steps) 10/7
%         % reduced reward (to 0.25) and increased penalty (to 15s) 10/17
%         % moved to easy varied duration 12/20
%         % moved to hard varied duration 1/5
%         
%         subjectID = '263';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('263'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.1 10/7
%         % increased penalty to 15 s 10/17
%         % increased reward and reduced timeout to improve motivation 11/16
%         % increased pemnalty to 10s 12/20
%         % increased reward(0.25) and increased penalty(15s) 1/5
%         % increased reward and increased timeout 2/2
%         % decreased reward to 0.25 and penalty to 10s 3/22
%         % moved animal to reversal with longer duration of stimulus 4/6
%         
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
% 
%         subjectID = '250';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('250'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         % forced graduation to step 4 9/13
%         % reduced reward to 0.1 9/13
%         % increased penalty to 15 s 10/7
%         % reduced reward to 0.05 10/17
%         % increased penalty to 25s 11/2
%         % increased reward to 0.25
%         % moved to rig 1 from 5 11/11
%         % moved back to step 5 11/16
%         % reduced timeout to 15s 12/20
%         % increased reward and increased timeout 2/2
%         % decreased reward to 0.25 and penalty to 10s 3/22
%
%         subjectID = '248';
%         sub = subject('248','mouse','c57bl/6j','male','2/27/2014','unknown','a 2/27/2014','Jackson Laboratories','PV-cre','none');
%         rx = addSubject(rx, sub, 'bas');
%         step = 7;
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('248'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         % reduced reward to 0.25 9/13
%         % increased pealty to 15000 on 9/13
%         % increased penalty to 20000 10/7
%         % reduced reward to 0.1 10/10
%         % increased reward to 0.25 11/6(seeing if increases motivation)
%         % reduced reward to 0.15 11/16
%         % trying to increase motivation inc. rew to 0.5 12/20
%         % reduced reward to 0.25 2/2
%         % decreased timeout to 10s


%         subjectID = '266';
% %         sub=getSubjectFromID(rx,subjectID);
% %         sub = subject('266','mouse','c57bl/6j','male','12/30/2014','unknown','a 12/30/2014','Jackson Laboratories','ChatChR2XVIP','none');
% %         rx = addSubject(rx, sub, 'bas');
% %         [~, step] = getProtocolAndStep(sub);
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('266'),true,true,true,step,rx,'mouseTraining_Init','bas');

        sub = subject('270','mouse','c57bl/6j','male','10/01/2014','unknown','a 10/01/2014','Jackson Laboratories','Som-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,1,rx,'mouseTraining_OD','bas');

        sub = subject('271','mouse','c57bl/6j','male','10/01/2014','unknown','b 10/01/2014','Jackson Laboratories','Som-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('272','mouse','c57bl/6j','male','10/26/2014','unknown','a 10/26/2014','Jackson Laboratories','Pv-Chr2XSom-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,1,rx,'mouseTraining_OD','bas');

    case 'A41F729213E2' %gLab-Behavior2
        
%         subjectID = '232';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 3;
%         [~, rx]=setProtocolAndStep(sub,pODSweeps('232'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % degraduated to step 3 9/13
%
%         subjectID = '253';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('253'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % sent to pOD at the object task 10/7
%         % increased penalty to 15s 11/2
%         % reduced reward to 0.15 11/6
%         % increased penalty to 11/16
%         % reduced penalty to 10s 12/20
%         % increased reward and increased penalty 1/5
%         % reduced reward to 0.25 2/2
%         % moved animal to reversal with longer duration of stimulus 4/6
%         % moved to orientation task 5/4
        
% 
%         subjectID = '254';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('254'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed to pOD and reduced reward to 0.25 10/7
%         % reduced reward to 0.1 10/17
%         % manually sent to step 4 11/2
%         % increased timeout to 15s 12/20
%         % increased reward and increased timeout 2/2
%         % sent back to step 5 5/7
%
%         subjectID = '245';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pMotion('245'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 2 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         % change % corr trials, and dot size/number 9/3
%         % back to same step bu thte step is different also increased
%         % reward for subject 10/29
%         % increased reward to 0.2 and increased penalty to 20000 for
%         % improved performance 12/20
%         % increased reward (0.5) and increased timeout(25000) 2/2
%         % reduced reward to 0.25 3/22
%         % moved to optM2
%         %  animals are shit
% 
% 
%         subjectID = '242';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pMotion('242'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 4 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         % change % corr trials, and dot size/number 9/3
%         % reduced reward to 0.1 9/13
%         % sent back to the original task 10/28
%         
%         subjectID = '247';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 9;
%         [~, rx]=setProtocolAndStep(sub,pOD('247'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 4 on 7/29
%         % reduced the maxDuration for stim 20/8
%         % reduced reward to 0.25 9/13
%         % increased penalty to 20s 10/7
%         % reduced reward to 0.15 10/17
%         % reduced penalty to 5s 11/16
%         % biased and doing poorly - moving to original step 11/22
%         % moved to slow varDur 12/20
%         % moved to fast varDur 2/2
%         
%         subjectID = '259';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('259'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.1 10/7
%         % increased penalty to 10s 10/17
%         % manual shift to step 4 11/2
%         % increased reward to 0.2 and penalty to 15s 12/20
%         % inreased reward (0.4) and penalty to 25s 2/2
%         % decreased reward to 0.25 and msPEnalty to 10s 3/22
%         % recuced reward and timeout 5/4
% 
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');

%         subjectID = '267';
%         sub=getSubjectFromID(rx,subjectID);
% %         sub = subject('267','mouse','c57bl/6j','male','12/30/2014','unknown','b 12/30/2014','Jackson Laboratories','ChatChR2XVIP','none');
% %         rx = addSubject(rx, sub, 'bas');
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('267'),true,true,true,step,rx,'mouseTraining_Init','bas');
%         % added mouse 3/31/15

        sub = subject('273','mouse','c57bl/6j','male','10/26/2014','unknown','b 10/26/2014','Jackson Laboratories','Pv-Chr2XSom-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,1,rx,'mouseTraining_OD','bas');

    case 'A41F726EC11C' %gLab-Behavior3
        
%         subjectID = '227';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 9; 
%         [~, rx]=setProtocolAndStep(sub,pOD('227'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % increased penalty to 15000 on 9/13
%         % shifted to pOD at dur limited 10/7
%         % manual step change to 8 10/17
%         % manual step change to step 7 11/2
%         % moved to varied duration easy durations 11/16
%         % moved to fast varied duration 12/20
%         
%         subjectID = '255';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 4;
%         [~, rx]=setProtocolAndStep(sub,pOD('255'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.25 9/13
%         % changed to pOD at the object task and reduced reward to 0.1 10/7
%         % increased penalty to 15 s 11/2
%         % increased reward to 0.25 11/16
%         % reduced reward to 0.1 12/20
%         % increased reward to 0.5 2/2
%         % decreased reward to 0.25 and decreased penalty to 10s 3/22
%         % increased reward and increased timeout to 15s 5/7
%         % moved animal to step 4 - the guy sucks 5/12
%        
%         subjectID = '256';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('256'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.25 9/13
%         % changed to the OD protocol at the object task 10/7
%         % probably increased penalty 11/2
%         % increased penalty to 20s 11/16
%         % inc reward and reduced timeout for increased motivation 12/20
%         % moved to orientation task 2/2
%         % increased reward to 0.5 and penalty to 20s 3/22
%         % moved animal to reversal with longer duration of stimulus 4/6
%         % reduced reward to 0.2 and penalty to 5 s 4/13
%         % moved back to orientation 5/6
%         
%         subjectID = '243';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5; 
%         [~, rx]=setProtocolAndStep(sub,pMotion('243'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20 
%         % change % corr trials, and dot size/number 9/3
%         % reduced reward to 0.1 9/13
%         % going back to the same task but the new step has two coherences
%         % increased reward to 0.2 and increased penalty to 20000 for
%         % improved performance 12/20
%         % moved animal to varied coherence on 3/22
%         % back to learning 3/29
% 
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
% 
%         subjectID = '262';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 5;
%         [~, rx]=setProtocolAndStep(sub,pOD('262'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.1 10/7
%         % moved to rig 3 from rig 5
%         % increased timeout to 15s 11/16
%         % increased reward to 0.5 12/20
%         % reduced reward (0.25) and reduced timeout(10000) 2/2
%         % moved animal to reversal with longer duration of stimulus 4/5
%         % moved to orientation task 5/4
% 
%         subjectID = '268';
%         sub=getSubjectFromID(rx,subjectID);
% %         sub = subject('268','mouse','c57bl/6j','female','10/31/2014','unknown','a 10/31/2014','Jackson Laboratories','ChatChR2XVIP','none');
% %         rx = addSubject(rx, sub, 'bas');
%         [~, step] = getProtocolAndStep(sub);
%         step = 3;
%         [~, rx]=setProtocolAndStep(sub,pOD('268'),true,true,true,step,rx,'mouseTraining_Init','bas');
%         % added mouse 3/31/15
%         % reduced reward and increased timeout 5/4
        
        sub = subject('274','mouse','c57bl/6j','male','11/14/2014','unknown','a 11/14/2014','Jackson Laboratories','Pv-Chr2XSom-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,1,rx,'mouseTraining_OD','bas');

    case '7845C4256F4C' %gLab-Behavior4
%         
%         subjectID = '244';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion('244'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         % change % corr trials, and dot size/number 9/3
%         % reduced reward to 0.1 9/13
%         % sent back to original task 10/29
%         % increased reward to 0.2 and increased penalty to 20000 for
%         % improved performance 12/20
%         % reduced reward (0.2) and reduced timeout(10000) 2/2
%         % increased reward to 0.5 and penalty to 20s 3/22
%         
%         subjectID = '249';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 9;
%         [~, rx]=setProtocolAndStep(sub,pOD('249'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         % sent back to step 5 - poor performance 10/7
%         % manual shift to step 8 10/17
%         % change to step 7 11/2
%         % varied duration with high duration 11/16
%         % moved to fast varDur 12/20
%      
% 
%         subjectID = '261';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('261'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.1 10/7
%         % increased penalty to 15s 10/17
%         % reduced reward to 0.05 11/2
%         % increased reward to 0.15 11/6
%         % inceased timeout to 20s 11/7
%         % reduced reward to 0.1 11/16
%         % trying to increase motivation inc. rew to 0.5 12/20
%         % reduced reward and reduced timeout 2/2
% 
% 
%         subjectID = '218';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         step = 9;
%         [~, rx]=setProtocolAndStep(sub,pOD('218'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % forced graduation to step 4 9/13
%         % sent to pOD at step 6 (dur limited) 10/7
%         % back to step 7 11/7
%         % moved 218 to rig 4
%         % moved to varied easy duration 11/16
%         % moved to fast varDur 12/20
%         
% 
%         subjectID = '257';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('257'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.25 9/13
%         % reduced reward to 0.1 10/7
%         % increased timeout to 15000 10/10
%         % reduced reward to 0.05 11/6
%         % moved to rig 4 
%         % increased reward to 0.25 11/16
%         % reduced reward to 0.15 12/20
%         % increased reward (0.5) and increased penalty (20s) 1/5
%         % reduced reward to 0.25 2/2
%                 
%         subjectID = '258';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('258'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % reduced reward to 0.25 9/13
%         % reduced reward to 0.1 10/7
%         % increased penalty to 15s 12/20
%
%         subjectID = '264';
% %         sub=getSubjectFromID(rx,subjectID);
%         sub = subject('264','mouse','c57bl/6j','male','10/31/2014','unknown','a 10/31/2014','Jackson Laboratories','ChatChR2XVIP','none');
%         rx = addSubject(rx, sub, 'bas');
% %         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pInit('264'),true,true,true,1,rx,'mouseTraining_Init','bas');
%         % added mouse 3/31/15
%         
%         subjectID = '265';
% %         sub=getSubjectFromID(rx,subjectID);
%         sub = subject('265','mouse','c57bl/6j','male','10/31/2014','unknown','b 10/31/2014','Jackson Laboratories','ChatChR2XVIP','none');
%         rx = addSubject(rx, sub, 'bas');
% %         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pInit('265'),true,true,true,1,rx,'mouseTraining_Init','bas');
%         % added mouse 3/31/15
%         
%         subjectID = '269';
%         sub=getSubjectFromID(rx,subjectID);
% %         sub = subject('269','mouse','c57bl/6j','female','10/31/2014','unknown','b 10/31/2014','Jackson Laboratories','ChatChR2XVIP','none');
% %         rx = addSubject(rx, sub, 'bas');
%         [~, step] = getProtocolAndStep(sub);
%         step = 1;
%         [~, rx]=setProtocolAndStep(sub,pInit('269'),true,true,true,step,rx,'mouseTraining_Init','bas');
%         % added mouse 3/31/15
%         % reduced reward and increased timeout 5/4

        sub = subject('275','mouse','c57bl/6j','male','11/14/2014','unknown','b 11/14/2014','Jackson Laboratories','Pv-Chr2XSom-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
    case '7845C42558DF' %gLab-Behavior5
                
% 
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
        
    case 'A41F729211B1' %gLab-Behavior6
        
%         subjectID = 'l001';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion_Lever('L001'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % increased dot size , increased velocity, reduced dot number and
%         % increased coherence 9/15
%         subjectID = 'l002';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion_Lever('L002'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % increased dot size , increased velocity, reduced dot number and
%         % increased coherence 9/15
%         
%         sub = subject('l003','mouse','c57bl/6j','female','02/27/2014','unknown','a 02/27/2014','Jackson Laboratories','PV-cre','none');
%         rx = addSubject(rx, sub, 'bas');
%         [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,3,rx,'mouseTraining_OD','bas');
%         
%         sub = subject('l004','mouse','c57bl/6j','female','02/27/2014','unknown','a 02/27/2014','Jackson Laboratories','PV-cre','none');
%         rx = addSubject(rx, sub, 'bas');
%         [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,3,rx,'mouseTraining_OD','bas');

%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
    otherwise
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

end