function calibrateWaterPorts(MSPortsOpen,numTimesPortsOpen)
%CALIBRATEWATERPORTS Use this function to measure the amount of water
%ejected by the ports.

[~,mac] = getMACaddress;
machines={{'1U',mac,uint8([1 1 1])}};
dataPath=fullfile(fileparts(fileparts(getRatrixPath)),'ratrixData',filesep);
path=fullfile(dataPath, 'Stations',sprintf('station%s',machines{1}{1}));

rewardMethod = 'localTimed';
pportaddr = '0378';
s=makeDefaultStation(machines{1}{1},path,mac,machines{1}{3},[],rewardMethod,pportaddr,'',false); % soundON is not set here

setValves(s,[0 0 0]);
for i = 1:numTimesPortsOpen
    i
    setValves(s,[1 1 1]);
    WaitSecs(MSPortsOpen/1000);
    setValves(s,[0 0 0])
    WaitSecs(0.5);
end
end

