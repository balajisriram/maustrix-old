function analyze_PV_HM3D_Images

Subjects = {'61','63','65','69','200','201'};




%% plot Images

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
analysisFor.analyzeQuatRadContrast = false;
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

plotDetails.axHan = subplot(3,3,1:3);
compiledFilesDir = {...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled'};
ctrAll = analyzeMouse({'61','63','65','69','200','201'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
hold on;

fitIn.cntr = ctrAll.ctrImageData.contrasts/100;
fitIn.pHat = ctrAll.ctrImageData.performanceByConditionWCO(:,1,1)';
fitOut(1) = fitHyperbolicRatio(fitIn);
plot(fitOut(1).fittedModel.c,fitOut(1).fittedModel.pModel,'b','lineWidth',3);

fitIn.cntr = ctrAll.ctrImageData.contrasts/100;
fitIn.pHat = ctrAll.ctrImageData.performanceByConditionWCO(:,1,2)';
fitOut(2) = fitHyperbolicRatio(fitIn);
plot(fitOut(2).fittedModel.c,fitOut(2).fittedModel.pModel,'r','lineWidth',3);



plotDetails.axHan = subplot(3,3,4);hold on;
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';
c1 = analyzeMouse('61',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
fitIn.cntr = c1.ctrImageData.contrasts/100;
fitIn.pHat = c1.ctrImageData.performanceByConditionWCO(:,1,1)';
fitInd(1,1) = fitHyperbolicRatio(fitIn);
plot(fitInd(1,1).fittedModel.c,fitInd(1,1).fittedModel.pModel,'b','lineWidth',3);
fitIn.cntr = c1.ctrImageData.contrasts/100;
fitIn.pHat = c1.ctrImageData.performanceByConditionWCO(:,1,2)';
fitInd(1,2) = fitHyperbolicRatio(fitIn);
plot(fitInd(1,2).fittedModel.c,fitInd(1,2).fittedModel.pModel,'r','lineWidth',3);

plotDetails.axHan = subplot(3,3,5); hold on;
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';
c2 = analyzeMouse('63',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
fitIn.cntr = c2.ctrImageData.contrasts/100;
fitIn.pHat = c2.ctrImageData.performanceByConditionWCO(:,1,1)';
fitInd(2,1) = fitHyperbolicRatio(fitIn);
plot(fitInd(2,1).fittedModel.c,fitInd(2,1).fittedModel.pModel,'b','lineWidth',3);
fitIn.cntr = c2.ctrImageData.contrasts/100;
fitIn.pHat = c2.ctrImageData.performanceByConditionWCO(:,1,2)';
fitInd(2,2) = fitHyperbolicRatio(fitIn);
plot(fitInd(2,2).fittedModel.c,fitInd(2,2).fittedModel.pModel,'r','lineWidth',3);

plotDetails.axHan = subplot(3,3,6);hold on;
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';
c3 = analyzeMouse('65',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
fitIn.cntr = c3.ctrImageData.contrasts/100;
fitIn.pHat = c3.ctrImageData.performanceByConditionWCO(:,1,1)';
fitInd(3,1) = fitHyperbolicRatio(fitIn);
plot(fitInd(3,1).fittedModel.c,fitInd(3,1).fittedModel.pModel,'b','lineWidth',3);
fitIn.cntr = c3.ctrImageData.contrasts/100;
fitIn.pHat = c3.ctrImageData.performanceByConditionWCO(:,1,2)';
fitInd(3,2) = fitHyperbolicRatio(fitIn);
plot(fitInd(3,2).fittedModel.c,fitInd(3,2).fittedModel.pModel,'r','lineWidth',3);

plotDetails.axHan = subplot(3,3,7);hold on;
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';
c4 = analyzeMouse('69',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
fitIn.cntr = c4.ctrImageData.contrasts/100;
fitIn.pHat = c4.ctrImageData.performanceByConditionWCO(:,1,1)';
fitInd(4,1) = fitHyperbolicRatio(fitIn);
plot(fitInd(4,1).fittedModel.c,fitInd(4,1).fittedModel.pModel,'b','lineWidth',3);
fitIn.cntr = c4.ctrImageData.contrasts/100;
fitIn.pHat = c4.ctrImageData.performanceByConditionWCO(:,1,2)';
fitInd(4,2) = fitHyperbolicRatio(fitIn);
plot(fitInd(4,2).fittedModel.c,fitInd(4,2).fittedModel.pModel,'r','lineWidth',3);

plotDetails.axHan = subplot(3,3,8);hold on;
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';
c5 = analyzeMouse('200',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
fitIn.cntr = c5.ctrImageData.contrasts/100;
fitIn.pHat = c5.ctrImageData.performanceByConditionWCO(:,1,1)';
fitInd(5,1) = fitHyperbolicRatio(fitIn);
plot(fitInd(5,1).fittedModel.c,fitInd(5,1).fittedModel.pModel,'b','lineWidth',3);
fitIn.cntr = c5.ctrImageData.contrasts/100;
fitIn.pHat = c5.ctrImageData.performanceByConditionWCO(:,1,2)';
fitInd(5,2) = fitHyperbolicRatio(fitIn);
plot(fitInd(5,2).fittedModel.c,fitInd(5,2).fittedModel.pModel,'r','lineWidth',3);

plotDetails.axHan = subplot(3,3,9);hold on;
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\PV-V1-hM3D\Compiled';
c6 = analyzeMouse('201',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
fitIn.cntr = c6.ctrImageData.contrasts/100;
fitIn.pHat = c6.ctrImageData.performanceByConditionWCO(:,1,1)';
fitInd(6,1) = fitHyperbolicRatio(fitIn);
plot(fitInd(6,1).fittedModel.c,fitInd(6,1).fittedModel.pModel,'b','lineWidth',3);
fitIn.cntr = c6.ctrImageData.contrasts/100;
fitIn.pHat = c6.ctrImageData.performanceByConditionWCO(:,1,2)';
fitInd(6,2) = fitHyperbolicRatio(fitIn);
plot(fitInd(6,2).fittedModel.c,fitInd(6,2).fittedModel.pModel,'r','lineWidth',3);


c50PBS = [];
c50CNO = [];

for i = 1:6
    c50PBS(i) = fitInd(i,1).c50;
    c50CNO(i) = fitInd(i,2).c50;
end