function analyze_PV_HM3D_Images

Subjects = {'61','63','65','69','200','201'};




%% plot Contrast

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
analysisFor.analyzeQuatRadContrast = false;,
analysisFor.analyzeImagesContrast = true;


filters = 735564:735574;
trialNumCutoff = 25;

splits.daysPBS = [735565 735569 735570 735572];
splits.daysCNO = [735564 735571 735573 735574];
splits.daysIntact = [];
splits.daysLesion = [];

f = figure('name','HM3D PERFORMANCE BY CONTRAST');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';
% 
% plotDetails.axHan = subplot(3,3,1:3);
% compiledFilesDir = {'\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled'};
% ctrAll = analyzeMouse({'61','63','65','69','200','201'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
% 

plotDetails.axHan = subplot(3,3,4);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('61',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,3,5);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('63',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,3,6);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('65',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,3,7);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
analyzeMouse('69',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,3,8);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
analyzeMouse('200',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,3,9);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
analyzeMouse('201',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);