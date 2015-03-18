function analyze_CoherentDots_Mice
Subjects = {'241','242','243','244','245'};


%% plot VarCoh
%% 241
analysisFor.analyzeCoherence = true;

analysisFor.tsName = 'OptM';


filters =today-2:today; %'Jun-17-2013':today
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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\Motion\Compiled';

c1 = analyzeMouse('241',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

%% 242
analysisFor.analyzeCoherence = true;

analysisFor.tsName = 'OptM';


filters =today-4:today; %'Jun-17-2013':today
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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\Motion\Compiled';

c1 = analyzeMouse('242',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

%% 244
analysisFor.analyzeCoherence = true;

analysisFor.tsName = 'OptM';


filters =today-2:today; %'Jun-17-2013':today
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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\Motion\Compiled';

c1 = analyzeMouse('244',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

%% 243
analysisFor.analyzeCoherence = true;

analysisFor.tsName = 'OptM';


filters =today-2:today; %'Jun-17-2013':today
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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\Motion\Compiled';

c1 = analyzeMouse('243',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


%% 245
analysisFor.analyzeCoherence = true;

analysisFor.tsName = 'OptM';


filters =today-2:today; %'Jun-17-2013':today
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
compiledFilesDir = '\\ghosh-nas.ucsd.edu\ghosh\Behavior\Motion\Compiled';

c1 = analyzeMouse('245',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


