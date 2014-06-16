function runOnce_AG

[~, b] = getMACaddress();
switch b
    case 'A41F7278B4DE' %gLab-Behavior1
        sub = subject('223','mouse','c57bl/6j','male','unknown','unknown','unknown','Jackson Laboratories','PV-cre','none');
    case 'A41F729213E2' %gLab-Behavior2
        gmail('balajisriram@gmail.com','Error in Rig 2',message);
    case 'A41F726EC11C' %gLab-Behavior3
        gmail('balajisriram@gmail.com','Error in Rig 3',message);
    case '7845C4256F4C' %gLab-Behavior4
        gmail('balajisriram@gmail.com','Error in Rig 4',message);
    case '7845C42558DF' %gLab-Behavior5
        gmail('balajisriram@gmail.com','Error in Rig 5',message);
    case 'A41F729211B1' %gLab-Behavior6
        gmail('balajisriram@gmail.com','Error in Rig 6',message);
    case 'BC305BD38BFB' %gLab-Behavior6
        gmail('balajisriram@gmail.com','Error in ephys-stim',message);
    otherwise
        warning('not sure which computer you are using. add that mac to this step. delete db and then continue. also deal with the other createStep functions.');
        keyboard;
end

end