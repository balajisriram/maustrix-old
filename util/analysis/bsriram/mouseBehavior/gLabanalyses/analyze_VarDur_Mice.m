function analyze_VarDur_Mice

Subjects = {'223','249','218','227','246'};

%% all
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

analysisFor.tsName = 'orDUR_LowDur_Sweep';

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
compiledFilesDir = {'\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled','\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled','\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled'};

c1 = analyzeMouse({'223','218','227'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

c= {};
%% plot VarDur
% 223
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

analysisFor.tsName = 'orDURSweep';


filters = 1:today-7; %'Jun-17-2013':today
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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled';

c1Easy = analyzeMouse('223',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

%% 218
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

analysisFor.tsName = 'orDUR_LowDur_Sweep';

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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled';

c1 = analyzeMouse('218',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
%% 249
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

analysisFor.tsName = 'orDUR_LowDur_Sweep';

filters = 1:today-3; %'Jun-17-2013':today
trialNumCutoff = 25;

splits.daysPBS = [];
splits.daysCNO = [];
splits.daysIntact = [];
splits.daysLesion = [];

f = figure('name','PERFORMANCE BY VARIED DURATION');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';
plotDetails.plotMeansOnly = false;

plotDetails.axHan = subplot(1,1,1);
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled';

c1 = analyzeMouse('249',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


%% 227
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

analysisFor.tsName = 'orDUR_LowDur_Sweep';

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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\VarDur\Compiled';

c1 = analyzeMouse('227',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
