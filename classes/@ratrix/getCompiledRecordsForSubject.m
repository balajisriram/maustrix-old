function [compiledRecords]=getCompiledRecordsForSubject(r,subject)

sID = getID(subject);
disp(sprintf('loading compiled records for %s (from ratrix)',sID))

subjCompiledStorePath = fullfile(getStandAlonePath(r),'CompiledTrialRecords');
subjSearchStr = sprintf('%s.*.mat',sID);
d = dir(fullfile(subjCompiledStorePath,subjSearchStr));
if length(d)>1
    error('multiiple compiled records. clean up before use');
elseif isempty(d)==0
    compiledRecords = [];
else
    compiledRecords = load(fullfile(subjCompiledStorePath,d.name));
end