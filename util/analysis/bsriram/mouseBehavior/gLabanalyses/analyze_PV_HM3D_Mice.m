function analyze_PV_HM3D_Mice

Subjects = {'63','65','67','69'};

analysisFor.analyzeOpt = false;
analysisFor.analyzeImages = false;
analysisFor.analyzeRevOpt = false;
analysisFor.analyzeContrast = true;
analysisFor.analyzeRevContrast = false;
analysisFor.analyzeSpatFreq = false;
analysisFor.analyzeRevSpatFreq = false;
analysisFor.analyzeOrientation = false;
analysisFor.analyzeRevOrientation = false;

filters = 735402:today; %'Jun-17-2013':today
trialNumCutoff = 25;

splits.daysPBS = [735402 735404 735406 735409 735411 735413];
splits.daysCNO = [735403 735405 735407 735410 735412 735414];
splits.daysIntact = [];
splits.daysLesion = [];


%% plot Contrast
f = figure('name','HM3D PERFORMANCE BY CONTRAST');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';


plotDetails.axHan = subplot(3,2,1);
compiledFilesDir = {'\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled'};
ctrAll = analyzeMouse({'63','67','69'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

% lets do some fitting
% PBS
PBSFit = [];
PBSQuality = [];
for i = 1:1000
    in.cntr = ctrAll.ctrData.contrasts;
    in.pHat = nan(size(in.cntr));
    for j = 1:length(in.pHat)
        minPerf = ctrAll.ctrData.performanceByConditionWCO(j,2,1);
        maxPerf = ctrAll.ctrData.performanceByConditionWCO(j,3,1);
                in.pHat(j) = minPerf+rand*(maxPerf-minPerf);
%         in.pHat(j) = (minPerf+maxPerf)/2+randn*(maxPerf-minPerf)/4;
    end
    fit = fitHyperbolicRatio(in);
    PBSFit(end+1) = fit.c50;
    PBSQuality(end+1) = fit.quality;

    if rand<0.01
        hold on;
        plot(gca,fit.fittedModel.c,fit.fittedModel.pModel,'b','linewidth',0.5);
    end
end
in.cntr = ctrAll.ctrData.contrasts;
in.pHat = ctrAll.ctrData.performanceByConditionWCO(:,1,1)';
fit = fitHyperbolicRatio(in);
plot(gca,fit.fittedModel.c,fit.fittedModel.pModel,'b','linewidth',3);
PBSBestC50 = fit.c50;
PBSFit = PBSFit(PBSQuality>0.64);

CNOFit = [];
CNOQuality = [];
for i = 1:1000
    in.cntr = ctrAll.ctrData.contrasts;
    in.pHat = nan(size(in.cntr));
    for j = 1:length(in.pHat)
        minPerf = ctrAll.ctrData.performanceByConditionWCO(j,2,2);
        maxPerf = ctrAll.ctrData.performanceByConditionWCO(j,3,2);
                in.pHat(j) = minPerf+rand*(maxPerf-minPerf);
%         in.pHat(j) = (minPerf+maxPerf)/2+randn*(maxPerf-minPerf)/4;
    end
    fit = fitHyperbolicRatio(in);
    CNOFit(end+1) = fit.c50;
    CNOQuality(end+1) = fit.quality;
    if rand<0.01
        hold on;
        plot(gca,fit.fittedModel.c,fit.fittedModel.pModel,'r','linewidth',0.5)
    end
end
in.cntr = ctrAll.ctrData.contrasts;
in.pHat = ctrAll.ctrData.performanceByConditionWCO(:,1,2)';
fit = fitHyperbolicRatio(in);
plot(gca,fit.fittedModel.c,fit.fittedModel.pModel,'r','linewidth',3);
CNOBestC50 = fit.c50;
CNOFit = CNOFit(CNOQuality>0.64);

plotDetails.axHan = subplot(3,2,2);
edges = 0:0.025:1;
nPBS = histc(PBSFit,edges);
nCNO = histc(CNOFit,edges);
fh = fill([edges fliplr(edges)],[nPBS/length(PBSFit) zeros(size(nPBS))],'b');set(fh,'edgealpha',0,'facealpha',0.5);hold on;
fh = fill([edges fliplr(edges)],[nCNO/length(CNOFit) zeros(size(nCNO))],'r');set(fh,'edgealpha',0,'facealpha',0.5);
xlabel('c50');
ylabel('fraction');
[h p] = ttest2(PBSFit,CNOFit)
plot(PBSBestC50,0.25,'bd');
plot(CNOBestC50,0.25,'rd');
set(gca,'ylim',[0 0.3]);
keyboard


plotDetails.axHan = subplot(3,2,3);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('63',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,2,4);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('65',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,2,5);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
analyzeMouse('67',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotDetails.axHan = subplot(3,2,6);
compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
analyzeMouse('69',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


% %% trialsByDay
% f = figure('name','HM3D NUM. TRIALS BY DAY');
% 
% plotDetails.plotOn = true;
% plotDetails.plotWhere = 'givenAxes';
% plotDetails.requestedPlot = 'trialsByDay';
% 
% plotDetails.axHan = subplot(2,2,1);
% compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
% analyzeMouse('63',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
% 
% plotDetails.axHan = subplot(2,2,2);
% compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
% analyzeMouse('65',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
% 
% plotDetails.axHan = subplot(2,2,3);
% compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';
% analyzeMouse('67',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);
% 
% plotDetails.axHan = subplot(2,2,4);
% compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled';
% analyzeMouse('69',filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);