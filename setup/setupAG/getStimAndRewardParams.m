function out = getStimAndRewardParams(out,subID)

switch subID
    case '218'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '227'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reward reduced to 0.1 8/10
    case '228'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/3
    case '232'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 on 8/10
    case '237'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/3
    case '238'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '239'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '240'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '241'
        out.rewardScalar = 0.5;
        out.msPenalty = 15000;
        % reduced reward to 0.5 8/3
        % increased penalty to 15000 on 8/10
    case '242'
        out.rewardScalar = 0.25;
        out.msPenalty = 15000;
        % reduced reward to 0.25 8/3
    case '243'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/3
    case '244'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/3
    case '245'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '247'
        out.msPenalty = 15000;
        % increased pealty to 15000 on 8/10
    case '249'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/10
    case '250'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/10
    otherwise
        % use the default setup
end
