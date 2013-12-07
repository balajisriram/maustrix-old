function analyze_PV_HM3D_Mice

Subjects = {'63','65','67','69'};




%% plot Contrast

analysisFor.analyzeOpt = false;
analysisFor.analyzeImages = false;
analysisFor.analyzeRevOpt = false;
analysisFor.analyzeContrast = true;
analysisFor.analyzeRevContrast = false;
analysisFor.analyzeSpatFreq = false;
analysisFor.analyzeRevSpatFreq = false;
analysisFor.analyzeOrientation = false;
analysisFor.analyzeRevOrientation = false;
analysisFor.analyzeTempFreq = false;
analysisFor.analyzeRevTempFreq = false;

filters = 735402:735414; %'Jun-17-2013':today
trialNumCutoff = 25;

splits.daysPBS = [735402 735404 735406 735409 735411 735413];
splits.daysCNO = [735403 735405 735407 735410 735412 735414];
splits.daysIntact = [];
splits.daysLesion = [];

f = figure('name','HM3D PERFORMANCE BY CONTRAST');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';

plotDetails.axHan = subplot(3,2,1);
compiledFilesDir = {'\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled'};
ctrAll = analyzeMouse({'63','65','67','69'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);

plotResponsetimes = true;
if plotResponseTimes
    temp = ctrAll.ctrData.correction; temp(isnan(temp)) = true;
    whichOK = ~isnan(ctrAll.ctrData.correct)&~(temp);
    goodContrasts = ctrAll.ctrData.contrast(whichOK);
    goodTrialNum = ctrAll.ctrData.trialNum(whichOK);
    goodCorrects = ctrAll.ctrData.correct(whichOK);
    goodResponseTimes = ctrAll.ctrData.responseTime(whichOK);
    whichOK = goodResponseTimes<5;
    goodContrasts = goodContrasts(whichOK);
    goodTrialNum = goodTrialNum(whichOK);
    goodCorrects = goodCorrects(whichOK);
    goodResponseTimes = goodResponseTimes(whichOK);
    
    figure; 
    
    subplot(2,2,1);
    hist(goodResponseTimes,100,'k'); hold on;
    plot(nanmean(goodResponseTimes),1000,'kd');
    plot([(nanmean(goodResponseTimes)-nanstd(goodResponseTimes)) (nanmean(goodResponseTimes)+nanstd(goodResponseTimes))],[1000 1000],'k');
    set(gca,'xlim',[0 5],'ylim',[0 1200]);
    
    subplot(2,2,2);
    responseMeanByContrast = nan(size(ctrAll.ctrData.contrasts));
    responseSTDByContrasts = responseMeanByContrast;
    responseSEMByContrasts = responseMeanByContrast;
    contrasts = ctrAll.ctrData.contrasts;
    for i = 1:length(contrasts)
        trialsThatContrast = goodContrasts==contrasts(i);
        responseTimesThatContrast = goodResponseTimes(trialsThatContrast);
        responseMeanByContrast(i) = nanmean(responseTimesThatContrast);
        responseSTDByContrasts(i) = nanstd(responseTimesThatContrast);
        responseSEMByContrasts(i) = responseSTDByContrasts(i)/sqrt(length(responseTimesThatContrast));
    end
    plot(contrasts,responseMeanByContrast,'kd');hold on;
    for i = 1:length(contrasts)
        plot([contrasts(i) contrasts(i)],[responseMeanByContrast(i)+2*responseSEMByContrasts(i) responseMeanByContrast(i)-2*responseSEMByContrasts(i)],'k')
    end
    set(gca,'xlim',[-0.1 1.1],'ylim',[1 1.6]);
    
    subplot(2,2,3); hold on;
    deciles = quantile(goodResponseTimes,9);
    performanceByTimeAndContrast = nan(10,length(contrasts));
    deciles = [0 deciles]; deciles = [deciles 5];
    for i = 1:10
        for j = 1:length(contrasts)
            whichTrialsThatContrastThatDecile = (goodContrasts == contrasts(j)) & (goodResponseTimes>deciles(i)) & ((goodResponseTimes<deciles(i+1)));
            correctsThatContrastThatDecile = goodCorrects(whichTrialsThatContrastThatDecile);
            performanceByTimeAndContrast(i,j) = nansum(correctsThatContrastThatDecile)/length(correctsThatContrastThatDecile);
        end
    end
    
    for i = 1:2:length(contrasts)
        plot(1:10,squeeze(performanceByTimeAndContrast(:,i)),'color',1-(i/length(contrasts)*[1 1 1]))
    end
    set(gca,'xlim',[0 11],'ylim',[0.3 0.8])
    plot(1:10,squeeze(performanceByTimeAndContrast(:,end)),'color',1-(8/length(contrasts)*[1 1 1]));
    plot([1 10],[0.5 0.5],'k');
end

oldFits = false;
if oldFits
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
end

numResamples = 10;
c50Difference = nan(1,numResamples);
qPBS = c50Difference;
qCNO = qPBS;

inPBS.cntr = ctrAll.ctrData.contrasts;
inCNO.cntr = ctrAll.ctrData.contrasts;
% lets do the shuffle
numTrialsByConditionPBS = ctrAll.ctrData.numTrialsByConditionWCO(:,1);
numTrialsByConditionCNO = ctrAll.ctrData.numTrialsByConditionWCO(:,2);

correctByConditionPBS = ctrAll.ctrData.correctByConditionWCO(:,1);
correctByConditionCNO = ctrAll.ctrData.correctByConditionWCO(:,2);
oneZerosForResample = cell(length(inPBS.cntr),1);
for j = 1:length(inPBS.cntr)
    oneZerosForResample{j} = zeros(1,numTrialsByConditionPBS(j)+numTrialsByConditionCNO(j));
    oneZerosForResample{j}(1:correctByConditionPBS(j)+correctByConditionCNO(j)) = 1;
end
currentShuffle = oneZerosForResample;
for i = 1:numResamples
    currentPBS = nan(1,length(numTrialsByConditionPBS));
    currentCNO = nan(1,length(numTrialsByConditionCNO));
    for j = 1:length(inPBS.cntr)
        currentShuffle{j} = oneZerosForResample{j}(randperm(length(oneZerosForResample{j})));
        currentPBS(j) = sum(currentShuffle{j}(1:numTrialsByConditionPBS(j)));
        currentCNO(j) = sum(currentShuffle{j}(numTrialsByConditionPBS(j)+1:end));
    end
    inPBS.pHat = currentPBS./numTrialsByConditionPBS';
    inCNO.pHat = currentCNO./numTrialsByConditionCNO';
    
    fitPBS = fitHyperbolicRatio(inPBS);
    qPBS(i) = fitPBS.quality;
    fitCNO = fitHyperbolicRatio(inCNO);
    qCNO(i) = fitCNO.quality;

%     keyboard
    %     plot(inPBS.cntr,inPBS.pHat,'b');
%     plot(inCNO.cntr,inCNO.pHat,'r');
%     plot(inCNO.cntr,inPBS.pHat-inCNO.pHat+0.5,'k');
    c50Difference(i) = fitPBS.c50-fitCNO.c50;
end
% best PBS
in.cntr = ctrAll.ctrData.contrasts;
in.pHat = ctrAll.ctrData.performanceByConditionWCO(:,1,1)';
fit = fitHyperbolicRatio(in);
% plot(gca,fit.fittedModel.c,fit.fittedModel.pModel,'b','linewidth',3);
PBSBestC50 = fit.c50;

% best CNO
in.cntr = ctrAll.ctrData.contrasts;
in.pHat = ctrAll.ctrData.performanceByConditionWCO(:,1,2)';
fit = fitHyperbolicRatio(in);
% plot(gca,fit.fittedModel.c,fit.fittedModel.pModel,'r','linewidth',3);
CNOBestC50 = fit.c50;

keyboard
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

%% PLOT ORIENTATION 

analysisFor.analyzeOpt = false;
analysisFor.analyzeImages = false;
analysisFor.analyzeRevOpt = false;
analysisFor.analyzeContrast = false;
analysisFor.analyzeRevContrast = false;
analysisFor.analyzeSpatFreq = false;
analysisFor.analyzeRevSpatFreq = false;
analysisFor.analyzeOrientation = true;
analysisFor.analyzeRevOrientation = false;
analysisFor.analyzeTempFreq = false;
analysisFor.analyzeRevTempFreq = false;

filters = 735416:today; %'Jun-17-2013':today
trialNumCutoff = 25;

splits.daysPBS = [735416 735418 735419 735423 735425 735427];
splits.daysCNO = [735417 735420 735421 735424 735426 735428]; % except for 65...
splits.daysIntact = [];
splits.daysLesion = [];

f = figure('name','HM3D PERFORMANCE BY ORIENTATION');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';

plotDetails.axHan = subplot(3,2,1);
compiledFilesDir = {'\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
%     '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled'};
OrAll = analyzeMouse({'63','67','69'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);




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

%% plot Contrast QUAT RAD

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
analysisFor.analyzeQuatRadContrast = true;
analysisFor.analyzeImagesContrast = false;

filters = 735458:735542; %'Jun-17-2013':today ,,735542,,735486
trialNumCutoff = 25;

splits.daysPBS = [];
splits.daysCNO = [];
splits.daysIntact = [];
splits.daysLesion = [];

f = figure('name','HM3D PERFORMANCE BY CONTRAST');
plotDetails.plotOn = true;
plotDetails.plotWhere = 'givenAxes';
plotDetails.requestedPlot = 'performanceByCondition';


plotDetails.axHan = subplot(3,2,1);
compiledFilesDir = {'\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box4\Compiled';...
    '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\Box5\Compiled'};
ctrAll = analyzeMouse({'63','65','69'},filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir);


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