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
switch mac
    case 'A41F7278B4DE' %gLab-Behavior1
%         subjectID = '223';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('223'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed protocol to variedDur and to step 5 on 7/29
%
        subjectID = '251';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('251'),true,true,true,step,rx,'mouseTraining_OD','bas');

        subjectID = '252';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('252'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
%         subjectID = '241';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion('241'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         
%         
%         subjectID = '246';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         
%         
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');

    case 'A41F729213E2' %gLab-Behavior2
        
%         subjectID = '232';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pODSweeps('232'),true,true,true,step,rx,'mouseTraining_OD','bas');
%                
        subjectID = '253';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('253'),true,true,true,step,rx,'mouseTraining_OD','bas');

        subjectID = '254';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('254'),true,true,true,step,rx,'mouseTraining_OD','bas');
% 
%         
%         
%         subjectID = '242';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion('242'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 4 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         
%         
%         subjectID = '247';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('247'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 4 on 7/29
%         % reduced the maxDuration for stim 20/8
%         
%         
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');

    case 'A41F726EC11C' %gLab-Behavior3
        
%         subjectID = '227';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pODSweeps('227'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
%         
        subjectID = '255';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('255'),true,true,true,step,rx,'mouseTraining_OD','bas');

        subjectID = '256';
        sub=getSubjectFromID(rx,subjectID);
        [~, step] = getProtocolAndStep(sub);
        [~, rx]=setProtocolAndStep(sub,pReversal('256'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
%         
%         subjectID = '243';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion('243'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20 
%         
%         
%         subjectID = '248';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('248'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         
%         
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
        

    case '7845C4256F4C' %gLab-Behavior4
                
%         subjectID = '228';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pODSweeps('228'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
%         
%         subjectID = '237';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pReversal('237'),true,true,true,1,rx,'mouseTraining_OD','bas');
%         
%         
%         subjectID = '238';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pReversal('238'),true,true,true,1,rx,'mouseTraining_OD','bas');
%         
% %         
%         subjectID = '244';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion('244'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%         
%         
%         subjectID = '249';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('249'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         
%         
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
        
    case '7845C42558DF' %gLab-Behavior5
                
%         subjectID = '218';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pODSweeps('218'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         
%         subjectID = '245';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pMotion('245'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 2 on 7/29
%         % enabled req reward while training
%         % changed the coherence and dot size on 8/20
%                
%         subjectID = '250';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('250'),true,true,true,step,rx,'mouseTraining_OD','bas');
%         % changed from step 1 to 3 on 7/29
%         % reduced the maxDuration for stim 20/8
%         
        sub = subject('257','mouse','c57bl/6j','female','04/11/2014','unknown','unknown','Jackson Laboratories','VIP-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pODSweeps('257'),true,true,true,1,rx,'mouseTraining_OD','bas');

        sub = subject('258','mouse','c57bl/6j','female','04/11/2014','unknown','unknown','Jackson Laboratories','VIP-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pODSweeps('257'),true,true,true,1,rx,'mouseTraining_OD','bas');

%         
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
        
        
    case 'A41F729211B1' %gLab-Behavior6
        
%         subjectID = '999';
%         sub=getSubjectFromID(rx,subjectID);
%         [~, step] = getProtocolAndStep(sub);
%         [~, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,step,rx,'mouseTraining_OD','bas');
    otherwise
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

end