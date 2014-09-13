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
pMotion_Lever = @mouseTraining_Motion_Lever;
switch mac
    case 'A41F7278B4DE' %gLab-Behavior1
        subjectID = '223';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('223'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed protocol to variedDur and to step 5 on 7/29

        subjectID = '251';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('251'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '252';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('252'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '241';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion('241'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % enabled req reward while training
        % changed the coherence and dot size on 8/20
        % change % corr trials, and dot size/number 9/3
        % reduced reward to 0.25 9/13
        
        subjectID = '246';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        step = 3;
        [~, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % reduced the maxDuration for stim 20/8
        % degraduated to step 3 9/13
        
        subjectID = '999';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');

    case 'A41F729213E2' %gLab-Behavior2
        
        subjectID = '232';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        step = 3;
        [~, rx]=setProtocolAndStep(sub,pODSweeps('232'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % degraduated to step 3 9/13
        
        subjectID = '253';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('253'),true,true,true,step,rx,'mouseTraining_OD','bas');

        subjectID = '254';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('254'),true,true,true,step,rx,'mouseTraining_OD','bas');

        subjectID = '242';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion('242'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 4 on 7/29
        % enabled req reward while training
        % changed the coherence and dot size on 8/20
        % change % corr trials, and dot size/number 9/3
        % reduced reward to 0.1 9/13
        
        subjectID = '247';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('247'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 4 on 7/29
        % reduced the maxDuration for stim 20/8
        % reduced reward to 0.25 9/13
        
        subjectID = '999';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');

    case 'A41F726EC11C' %gLab-Behavior3
        
        subjectID = '227';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pODSweeps('227'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % increased penalty to 15000 on 9/13
        
        subjectID = '255';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('255'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '256';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('256'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '243';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion('243'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % enabled req reward while training
        % changed the coherence and dot size on 8/20 
        % change % corr trials, and dot size/number 9/3
        % reduced reward to 0.1 9/13
        
        subjectID = '248';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('248'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % reduced the maxDuration for stim 20/8
        % reduced reward to 0.25 9/13
        % increased pealty to 15000 on 9/13
        
        subjectID = '999';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
        

    case '7845C4256F4C' %gLab-Behavior4
                
        subjectID = '228';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        step = 3;
        [~, rx]=setProtocolAndStep(sub,pODSweeps('228'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % degraduated to step 3 9/13
        
        subjectID = '237';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('237'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '238';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('238'),true,true,true,step,rx,'mouseTraining_OD','bas');
        
        subjectID = '244';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion('244'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % enabled req reward while training
        % changed the coherence and dot size on 8/20
        % change % corr trials, and dot size/number 9/3
        % reduced reward to 0.1 9/13
        
        subjectID = '249';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('249'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % reduced the maxDuration for stim 20/8
        
        
        subjectID = '999';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
        
        
    case '7845C42558DF' %gLab-Behavior5
                
        subjectID = '218';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        step = 4;
        [~, rx]=setProtocolAndStep(sub,pODSweeps('218'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % forced graduation to step 4 9/13
        
        subjectID = '245';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion('245'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 2 on 7/29
        % enabled req reward while training
        % changed the coherence and dot size on 8/20
        % change % corr trials, and dot size/number 9/3
               
        subjectID = '250';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        step = 4;
        [~, rx]=setProtocolAndStep(sub,pOD('250'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        % reduced the maxDuration for stim 20/8
        % forced graduation to step 4 9/13
        % reduced reward to 0.1 9/13
        
        subjectID = '257';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pODSweeps('257'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '258';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pODSweeps('258'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % reduced reward to 0.25 9/13
        
        subjectID = '999';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
        
        
    case 'A41F729211B1' %gLab-Behavior6
        
        subjectID = 'l001';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion_Lever('L001'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        subjectID = 'l002';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pMotion_Lever('L002'),true,true,true,step,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
    otherwise
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

end