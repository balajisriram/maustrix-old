function out = getStimAndRewardParams(out,subID)

switch lower(subID)
    case '218'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '227'
        out.rewardScalar = 0.1;
        out.msPenalty = 15000;
        % reduced reward to 0.25 8/3
        % reward reduced to 0.1 8/10
        % increased pealty to 15000 on 9/13
    case '228'
        out.rewardScalar = 0.15;
        out.msPenalty = 15000;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.15 10/17
        % increased timeout to 15000 10/17
    case '232'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 on 8/10
    case '237'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 9/13
    case '238'
        out.rewardScalar = 0.1;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
    case '239'
        out.rewardScalar = 0.05;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
        % reduced reward to 0.05 8/20
    case '240'
        out.rewardScalar = 0.05;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
        % reduced reward to 0.05 8/20
    case '241'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward to 0.5 8/3
        % increased penalty to 15000 on 8/10
        % reduced reward to 0.25 9/13
        % increased reward to 0.35 and increased penalty to 20000 for
        % improved performance 12/20
        % % reduced reward (0.25) and reduced timeout(10000) 2/2
    case '242'
        out.rewardScalar = 0.15;
        out.msPenalty = 15000;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 9/13
    case '243'
        out.rewardScalar = 0.2;
        out.msPenalty = 20000;
        % reduced reward to 0.25 8/3
        % increased penalty to 15000 9/6
        % reduced reward to 0.1 9/13
        % increased reward to 0.2 and increased penalty to 20000 for
        % improved performance 12/20
    case '244'
        out.rewardScalar = 0.5;
        out.msPenalty = 20000;
        % reduced reward to 0.25 8/3
        % increased penalty to 15000 9/6
        % reduced reward to 0.1 9/13
        % increased reward to 0.2 and increased penalty to 20000 for
        % improved performance 12/20
        % reduced reward (0.2) and reduced timeout(10000) 2/2
        % increased reward to 0.5 and penalty to 20s 3/22
    case '245'
        out.rewardScalar = 0.25;
        out.msPenalty = 25000;
        % reduced reward to 0.25 8/3
        % reduced reward to 0.1 8/10
        % reduced reward scalar to 0.02 9/6
        % increased reward to 0.2 and increased penalty to 20000 for
        % improved performance 12/20
        % increased reward (0.5) and increased timeout(25000) 2/2
        % reduced reward to 0.25 3/22
    case '246'
        out.rewardScalar = 0.25;
        out.msPenalty = 15000;
        % reduced reward and increased penalty 10/17
    case '247'
        out.rewardScalar = 0.15;
        out.msPenalty = 5000;
        % increased pealty to 15000 on 8/10
        % reduced reward to 0.25 9/13
        % increased penalty to 20s
        % reduced reward to 0.15 10/17
        % reduced penalty to 5s 11/16
    case '248'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward to 0.25 9/13
        % increased pealty to 15000 on 9/13
        % increased penalty to 20s 10/7
        % reduced reward to 0.1 10/10
        % increased reward to 0.25 11/6
        % reduced reward to 0.15 11/16
        % trying to increase motivation inc. rew to 0.5 12/20
        % reduced reward to 0.25 2/2
        % decreased timeout to 10s 3/22
    case '249'
        out.rewardScalar = 0.25;
        % reduced reward to 0.25 8/10
    case '250'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward to 0.25 8/10
        % reduced reward to 0.1 9/13
        % increased penalty to 15s 10/7
        % reduced reward to 0.05 10/17
        % increased penalty to 25 s 11/2
        % increased reward to 0.25 11/6
        % reduced timeout to 15s 12/20
        % increased reward and increased timeout 2/2
        % decreased reward to 0.25 and penalty to 10s 3/22
    case '251'
        out.rewardScalar = 0.1;
        out.msPenalty = 15000;
        % reduced reward to 0.25 9/13
        % reduced reward to 0.1 9/22
        % increaed timeout to 15000 10/7
    case '252'
        out.rewardScalar = 0.25;
        out.msPenalty = 25000;
        % reduced reward to 0.25 9/13
        % reduced reward to 0.1 9/22
        % increased timeout to 15 s 10/7
        % reduced rewards to 0.05;
        % increased reward to 0.1 11/2
        % increased 20s 11/16
        % increased reward and increased timeout 2/2
    case '253'
        out.msPenalty = 20000;
        out.rewardScalar = 0.25;
        % increased penalty to 15s 11/2
        % reduced reward to 0.15 11/6
        % increased penalty to 20s 11/16
        % reduced penalty to 10s 12/20
        % increased reward and increased penalty 1/5
        % reduced reward to 0.25 2/2
    case '254'
        out.rewardScalar = 0.25;
        out.msPenalty = 5000;
        % reduced reward to 0.25 10/7
        % reduced reward to 0.1 10/17
        % increased penalty to 15s 12/20
        % increased reward and increased timeout 2/2
        % reduced penalty hoping that tyhe animal learns the task 5/4
    case '255'
        out.rewardScalar = 0.25;
        out.msPenalty = 15000;
        % reduced reward to 0.25 9/13
        % reduced reward to 0.1 actually on 10/17
        % increased penalty to 15 s  11/2
        % increased reward to 11/16
        % reduced reward to 0.1 12/20
        % increased reward to 0.5 2/2
        % decreased reward to 0.25 and penalty to 10s 3/22
        % decreased reward substantially 5/4
        % increased timeout to 15000 5/7
    case '256'
        out.rewardScalar = 0.2;
        out.msPenalty = 5000;
        % reduced reward to 0.25 9/13
        % reduced reward to 0.1 10/7
        % increased penalty to 15 s 11/2
        % increased penalty to 20s 11/16
        % inc reward and reduced timeout for increased motivation 12/20
        % increased reward to 0.5 and penalty to 20s 3/22
        % reduced reward and reduced penalty (more trials?) 4/13
    case '257'
        out.rewardScalar = 0.25;
        out.msPenalty = 20000;
        % reduced reward to 0.25 9/13
        % reduced reward to 0.1 10/7
        % increased timeout to 15000 10/10
        % reduced reward to 0.05 11/6
        % increased reward to 0.25 11/16
        % reduced reward to 0.15 12/20
        % increased reward (0.5) and increased penalty (20s) 1/5
        % reduced reward to 0.25 2/2
    case '258'
        out.rewardScalar = 0.25;
        out.msPenalty = 25000;
        % reduced reward to 0.25 9/13
        % reduced reward to 0.1 10/7
        % increased penalty to 15s 12/20
        % increased reward and increased timeout 2/2
    case '259'
        out.rewardScalar = 0.15;
        out.msPenalty = 5000; 
        % reduced reward to 0.1 10/7
        % increased penlty to 10000 10/17
        % increased reward to 0.2 and penalty to 15s 12/20
        % increased penalty to 25s 2/2
        % reduced reward to 0.25 and msPenalty to 10s
        %  reduced reward and timepout 5/4
    case '261'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward to 0.1 10/7
        % increased penalty to 15s 10/17
        % increased reward to 0.15 11/7
        % increased timeput to 20 s 11/7
        % reduced reward to 0.1 11/16
        % trying to increase motivation inc. rew to 0.5 12/20
        % reduced reward and reduced timeout 2/2 (never got activated)
        % activated previous step 5/4
    case '262'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward to 0.1 10/7
        % increased penalty to 15s 11/16
        % increased reward to 0.5 - potential lerned helplessness 12/20
        % reduced reward (0.25) and reduced timeout(10000) 2/2
    case '263'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward to 0.1 10/7
        % increased penalty to 15s 10/17
        % increased reward to 0.2 and reduce penalty to 5s 11/16
        % increased pemnalty to 10s 12/20
        % increased reward(0.25) and increased penalty(15s) 1/5
        % increased reward and increased timeout 2/2
        % decreased reward to 0.25 and penalty to 10s 3/22
    case '268'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward and increased penalty to aid learning 5/4
    case '269'
        out.rewardScalar = 0.25;
        out.msPenalty = 10000;
        % reduced reward and increased penalty to aid learning 5/4
    case 'l001'
        out.rewardScalar = 0.25;
        % reduced reward 9/4;
    case 'l002'
        out.rewardScalar = 0.25;
        % reduced reward 9/4
    otherwise
        % use the default setup
end
