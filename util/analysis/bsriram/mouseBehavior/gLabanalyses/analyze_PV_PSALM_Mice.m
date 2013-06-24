function analyze_PV_PSALM_Mice

Subjects = {'60','62','64','66'};

analysisFor.analyzeOpt = false;
analysisFor.analyzeImages = false;
analysisFor.analyzeRevOpt = false;
analysisFor.analyzeContrast = true;
analysisFor.analyzeRevContrast = false;

filters = 735402:today; %'Jun-17-2013':today
trialNumCutoff = 25;

splits.daysPBS = [735402 735404 735406];
splits.daysCNO = [735403 735405 735407];
splits.daysIntact = [];
splits.daysLesion = [];

%% plot Contrast
f = figure('name','PSALM PERFORMANCE BY CONTRAST');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';

plotDetails.axHan = subplot(2,2,1);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box1\Compiled';
analyzeMouse('60',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,2);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('62',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,3);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('64',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,4);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('66',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


%% trialsByDay
f = figure('name','PSALM NUM. TRIALS BY DAY');

plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'trialsByDay';

plotDetails.axHan = subplot(2,2,1);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box1\Compiled';
analyzeMouse('60',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,2);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('62',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,3);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('64',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,4);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('66',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);