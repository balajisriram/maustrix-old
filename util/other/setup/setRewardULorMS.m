function setRewardULorMS(ids,val,stepNum,comment,auth)
if ~exist('auth','var')
    auth='unspecified'; %bad idea?
end

if ~exist('comment','var')
    comment='';
end

if ~exist('stepNum','var') || isempty(stepNum)
    stepNum='all';
end

setReinforcementParam('rewardULorMS',ids,val,stepNum,comment,auth);