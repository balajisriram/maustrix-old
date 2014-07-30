function out = getStimAndRewardParams(out,subID)

switch subID
    case '218'
        out.rewardScalar = 0.25;
    case '227'
        out.rewardScalar = 0.25;
    case '228'
        out.rewardScalar = 0.25;
    case '232'
        out.rewardScalar = 0.25;
    case '237'
        out.rewardScalar = 0.25;
    case '238'
        out.rewardScalar = 0.25;
    case '239'
        out.rewardScalar = 0.25;
    case '240'
        out.rewardScalar = 0.25;
    case '241'
        out.rewardScalar = 0.5;
    case '242'
        out.rewardScalar = 0.25;
        out.msPenalty = 15000;
    case '243'
        out.rewardScalar = 0.25;
    case '244'
        out.rewardScalar = 0.25;
    case '245'
        out.rewardScalar = 0.25;
    otherwise
        % use the default setup
end
