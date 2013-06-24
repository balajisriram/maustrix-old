function analyze_PV_HM3D_Mice

Subjects = {'63','65','67','69'};

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
f = figure('name','HM3D PERFORMANCE BY CONTRAST');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';



plotDetails.axHan = subplot(2,2,1);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('63',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,2);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('65',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,3);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('67',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,4);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
analyzeMouse('69',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


%% trialsByDay
f = figure('name','HM3D NUM. TRIALS BY DAY');

plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'trialsByDay';

plotDetails.axHan = subplot(2,2,1);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('63',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,2);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('65',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,3);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('67',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(2,2,4);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
analyzeMouse('69',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);