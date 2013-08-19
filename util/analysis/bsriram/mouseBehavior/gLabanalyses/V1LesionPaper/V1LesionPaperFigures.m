function V1LesionPaperFigures

plotFigure1 = true;

if plotFigure1
    clc;
    disp('Figure1a is a schematic');
    
    % plotting the training for a Opt for this mouse
    mouseID = '26';
    filters = 735150:735180;
    
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
    
    compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    
    out = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
end