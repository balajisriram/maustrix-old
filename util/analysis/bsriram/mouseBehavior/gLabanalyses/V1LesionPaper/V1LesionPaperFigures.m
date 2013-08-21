function V1LesionPaperFigures

plotFigure1 = true;

if plotFigure1
    clc;
    disp('Figure1a is a schematic');
    
    % plotting the training for a Opt for this mouse
    mouseID = '26';
    filters = 735150:735180;
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'learningProcess';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion';
    end
    
    out = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    %% time to threshold
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.requestedPlot = 'learningProcessOnlyAverage';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion';
    end
    
    % 22,23,25,26,48,40,47,53,56,59,37,38,45,50
    
    % 22
    filters = 1:today;
    out = {};
    plotDetails.axHan = subplot(3,5,1); out{1} = analyzeMouse('22',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,2); out{2} = analyzeMouse('23',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,3); out{3} = analyzeMouse('25',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,4); out{4} = analyzeMouse('26',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,5); out{5} = analyzeMouse('48',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,6); out{6} = analyzeMouse('40',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,7); out{7} = analyzeMouse('47',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,8); out{8} = analyzeMouse('53',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,9); out{9} = analyzeMouse('56',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,10); out{10} = analyzeMouse('59',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,11); out{11} = analyzeMouse('37',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,12); out{12} = analyzeMouse('38',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,13); out{13} = analyzeMouse('45',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,14); out{14} = analyzeMouse('50',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);

end