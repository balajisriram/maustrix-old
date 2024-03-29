function runOnce_AG

dataPath=fullfile(fileparts(fileparts(getRatrixPath)),'ratrixData',filesep);

try
    [success, mac]=getMACaddress();
    if ~success
        mac='000000000000';
    end
catch
    mac='000000000000';
end

machines={{'1U',mac,[1 1 1]}};
rx=createRatrixWithDefaultStations(machines,dataPath,'localTimed');
permStorePath=fullfile(dataPath,'PermanentTrialRecordStore');
mkdir(permStorePath);
rx=setStandAlonePath(rx,permStorePath);
fprintf('created new ratrix\n')

pOD = @mouseTraining_OD;
pODSweeps = @mouseTraining_ODSweeps;
pCtrSens = @mouseTraining_ctrSens;
pMotion = @mouseTraining_Motion;

switch mac
    case 'A41F7278B4DE' %gLab-Behavior1
        sub = subject('223','mouse','c57bl/6j','male','12/30/2012','unknown','unknown','Jackson Laboratories','VGAT-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('223'),true,true,true,5,rx,'mouseTraining_OD','bas');
        % changed protocol to variedDur and to step 5 on 7/29
        
        sub = subject('225','mouse','c57bl/6j','male','04/05/2013','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pCtrSens('225'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('226','mouse','c57bl/6j','male','04/05/2013','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pCtrSens('226'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('241','mouse','c57bl/6j','female','02/27/2014','unknown','a 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pMotion('241'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('246','mouse','c57bl/6j','female','02/27/2014','unknown','a 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('246'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('999','virtual','none','none','02/27/2014','unknown','unknown','Jackson Laboratories','none','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,5,rx,'mouseTraining_OD','bas');
    case 'A41F729213E2' %gLab-Behavior2
        sub = subject('232','mouse','c57bl/6j','female','09/02/2013','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pODSweeps('232'),true,true,true,3,rx,'mouseTraining_OD','bas');
        
        sub = subject('216','mouse','c57bl/6j','male','05/08/2013','unknown','unknown','Jackson Laboratories','VGAT-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pCtrSens('216'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('221','mouse','c57bl/6j','male','12/20/2012','unknown','unknown','Jackson Laboratories','VGAT-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pCtrSens('221'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('242','mouse','c57bl/6j','female','02/27/2014','unknown','a 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pMotion('242'),true,true,true,4,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 4 on 7/29
        
        sub = subject('247','mouse','c57bl/6j','female','02/27/2014','unknown','a 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('247'),true,true,true,4,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 4 on 7/29
        
        sub = subject('999','virtual','none','none','02/27/2014','unknown','unknown','Jackson Laboratories','none','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,5,rx,'mouseTraining_OD','bas');
    case 'A41F726EC11C' %gLab-Behavior3
        sub = subject('227','mouse','c57bl/6j','female','04/03/2013','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pODSweeps('227'),true,true,true,3,rx,'mouseTraining_OD','bas');
        
        sub = subject('213','mouse','c57bl/6j','male','05/08/2013','unknown','unknown','Jackson Laboratories','VGAT-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pCtrSens('213'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('220','mouse','c57bl/6j','female','12/26/2012','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pCtrSens('220'),true,true,true,1,rx,'mouseTraining_OD','bas');
        
        sub = subject('243','mouse','c57bl/6j','male','02/27/2014','unknown','b 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pMotion('243'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('248','mouse','c57bl/6j','male','02/27/2014','unknown','b 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('248'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('999','virtual','none','none','02/27/2014','unknown','unknown','Jackson Laboratories','none','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,5,rx,'mouseTraining_OD','bas');
    case '7845C4256F4C' %gLab-Behavior4
        sub = subject('228','mouse','c57bl/6j','male','08/03/2013','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pODSweeps('228'),true,true,true,3,rx,'mouseTraining_OD','bas');
        
        sub = subject('237','mouse','c57bl/6j','male','3/17/2014','unknown','unknown','Jackson Laboratories','VIP-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('237'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('238','mouse','c57bl/6j','male','3/17/2014','unknown','unknown','Jackson Laboratories','VIP-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('238'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('244','mouse','c57bl/6j','male','02/27/2014','unknown','b 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pMotion('244'),true,true,true,4,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 4 on 7/29
        
        sub = subject('249','mouse','c57bl/6j','male','02/27/2014','unknown','b 02/27/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('249'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('999','virtual','none','none','02/27/2014','unknown','unknown','Jackson Laboratories','none','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,5,rx,'mouseTraining_OD','bas');
    case '7845C42558DF' %gLab-Behavior5
        sub = subject('218','mouse','c57bl/6j','male','04/05/2013','unknown','unknown','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pODSweeps('218'),true,true,true,3,rx,'mouseTraining_OD','bas');
        
        sub = subject('239','mouse','c57bl/6j','female','2/13/2014','unknown','unknown','Jackson Laboratories','VIP-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('239'),true,true,true,2,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 2 on 7/29
        
        sub = subject('240','mouse','c57bl/6j','female','2/13/2014','unknown','unknown','Jackson Laboratories','VIP-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('240'),true,true,true,2,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 2 on 7/29
        
        sub = subject('245','mouse','c57bl/6j','male','02/05/2014','unknown','a 02/05/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pMotion('245'),true,true,true,2,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 2 on 7/29
        
        sub = subject('250','mouse','c57bl/6j','male','02/05/2014','unknown','a 02/05/2014','Jackson Laboratories','PV-cre','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('250'),true,true,true,3,rx,'mouseTraining_OD','bas');
        % changed from step 1 to 3 on 7/29
        
        sub = subject('999','virtual','none','none','02/27/2014','unknown','unknown','Jackson Laboratories','none','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pOD('999'),true,true,true,5,rx,'mouseTraining_OD','bas');
        
    case 'A41F729211B1' %gLab-Behavior6
        
        sub = subject('999','virtual','none','none','02/27/2014','unknown','unknown','Jackson Laboratories','none','none');
        rx = addSubject(rx, sub, 'bas');
        [sub, rx]=setProtocolAndStep(sub,pMotion('999'),true,true,true,5,rx,'mouseTraining_OD','bas');
    otherwise
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

end