function analyze_VarDur_Mice

Subjects = {'223'};




%% plot VarDur

analysisFor.analyzeOpt = false;
analysisFor.analyzeImages = false;
analysisFor.analyzeRevOpt = false;
analysisFor.analyzeContrast = false;
analysisFor.analyzeRevContrast = false;
analysisFor.analyzeSpatFreq = false;
analysisFor.analyzeRevSpatFreq = false;
analysisFor.analyzeOrientation = false;
analysisFor.analyzeRevOrientation = false;
analysisFor.analyzeTempFreq = false;
analysisFor.analyzeRevTempFreq = false;
analysisFor.analyzeCtrSensitivity = false;
analysisFor.analyzeQuatRadContrast = false;
analysisFor.analyzeImagesContrast = false;
analysisFor.analyzeVariedDurations = true;

filters = 1:today; %'Jun-17-2013':today
trialNumCutoff = 25;

splits.daysPBS = [];
splits.daysCNO = [];
splits.daysIntact = [];
splits.daysLesion = [];

f = figure('name','PERFORMANCE BY VARIED DURATION');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';
plotDetails.plotMeansOnly = true;

plotDetails.axHan = subplot(1,1,1);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\VarDur\Compiled';

c1 = analyzeMouse('223',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

