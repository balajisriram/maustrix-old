function d=display(s)
    d=['crossModal (switchType: ' s.modalitySwitchType '\n' ...
        '(switchTypeParameter: ' num2str(s.modalitySwitchParameter) '\n' ...
        '(switchMethod: ' s.modalitySwitchMethod '\n' ...
        '(blockingLength: ' num2str(s.blockingLength) '\n' ...
        '(currentModality: ' s.currentModality '\n' ...
        '\n\nSUBCOMPONENT STIM: ' display(s.hemifieldFlicker) ...
        '\n\nSUBCOMPONENT STIM: ' display(s.stereoDiscrim) '\n\n'];
    d=sprintf(d);