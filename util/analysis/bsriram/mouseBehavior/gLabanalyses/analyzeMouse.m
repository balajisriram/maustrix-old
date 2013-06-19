function out = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,splits,compiledFilesDir)
out = [];
if ~exist('plotDetails','var')||isempty(plotDetails)
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'makeFigure';
end

if ~exist('trialNumCutoff','var')||isempty(trialNumCutoff)
    trialNumCutoff = 25;
end

if ~exist('filters','var') || isempty(filters)
    % all data is allowed
    filters.fdFilter = 1:today;
    filters.imFilter = 1:today;
    filters.optFilter = 1:today;
    filters.optRevFilter = 1:today;
    filters.ctrFilter = 1:today;
    filters.ctrRevFilter = 1:today;
    filters.sfFilter = 1:today;
    filters.sfRevFilter = 1:today;
    filters.orFilter = 1:today;
    filters.orRevFilters = 1:today;
    filters.tfFilter = 1:today;
    filters.tfRevFilter = 1:today;
end

if ~exist('analysisFor','var')||isempty(analysisFor)
    analyzeImages = true;
    analyzeOpt = true;
    analyzeRevOpt = true;
else
    analyzeImages = analysisFor.analyzeImages;
    analyzeOpt = analysisFor.analyzeOpt;
    analyzeRevOpt = analysisFor.analyzeRevOpt;
end

if ~exist('splits','var')||isempty(splits)
    daysPBS = {};
    daysCNO = {};
    daysIntact = {};
    daysLesion = {};
else
    daysPBS = splits.daysPBS;
    daysCNO = splits.daysCNO;
    daysIntact = splits.daysIntact;
    daysLesion = splits.daysLesion;
end

data1 = load(findCompiledRecordsForSubject(compiledFilesDir,mouseID));

%% IMAGES
if analyzeImages
    out.imageData = analyzeImagesTrials(mouseID,data1,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end
%% +/- 45 GRATINGS
if analyzeOpt
    out.optData = analyzeOptTrials(mouseID,data1,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end

if analyzeRevOpt
    out.optReversalData = analyzeOptReversalTrials(mouseID,data1,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion);
end
% 
% %% CONTRAST 
% ctr1 = filterBehaviorData(data1,'tsName','orCTRSweep');%1x3453 trials 
% ctrData.trialNum = [ctr1.compiledTrialRecords.trialNumber];
% ctrData.correct = [ctr1.compiledTrialRecords.correct];
% ctrData.correction = [ctr1.compiledTrialRecords.correctionTrial];
% ctrData.contrast = [ctr1.compiledDetails(2).records.contrasts];
% ctrData.time = [ctr1.compiledTrialRecords.date];
% ctrData.date = floor(ctrData.time);
% ctrData.dates = unique(ctrData.date);
% ctrData.contrasts = unique(ctrData.contrast);
% 
% % performance on a day by day basis
% ctrData.trialNumByDate = cell(1,length(ctrData.dates));
% ctrData.numTrialsByDate = nan(1,length(ctrData.dates));
% ctrData.performanceByDate = nan(3,length(ctrData.dates));
% ctrData.colorByCondition = cell(1,length(ctrData.dates));
% ctrData.conditionNum = nan(1,length(ctrData.dates));
% ctrData.dayMetCutOffCriterion = nan(1,length(ctrData.dates));
% 
% %performance by condition
% ctrData.trialNumsByCondition = cell(length(ctrData.contrasts),5);
% ctrData.numTrialsByCondition = zeros(length(ctrData.contrasts),5);
% ctrData.correctByCondition = zeros(length(ctrData.contrasts),5);
% ctrData.performanceByCondition = nan(length(ctrData.contrasts),3,5);
% 
% %performance by condition with trial number cutoff
% ctrData.trialNumsByConditionWCO = cell(length(ctrData.contrasts),5);
% ctrData.numTrialsByConditionWCO = zeros(length(ctrData.contrasts),5);
% ctrData.correctByConditionWCO = zeros(length(ctrData.contrasts),5);
% ctrData.performanceByConditionWCO = nan(length(ctrData.contrasts),3,5);
% 
% for i = 1:length(ctrData.dates)
%     if ismember(ctrData.dates(i),filters.ctrFilter)
%         dateFilter = ctrData.date==ctrData.dates(i);
%         correctThatDate = ctrData.correct(dateFilter);
%         correctionThatDate = ctrData.correction(dateFilter);
%         contrastThatDate = ctrData.contrast(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         contrastThatDate = contrastThatDate(whichGood);
%  
%         ctrData.trialNumByDate{i} = ctrData.trialNum(dateFilter);
%         ctrData.trialNumByDate{i} = ctrData.trialNumByDate{i}(whichGood);
%         ctrData.numTrialsByDate(i) = length(ctrData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         ctrData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         ctrData.performanceByDate(1,i) = phat;
%         ctrData.performanceByDate(2,i) = pci(1);
%         ctrData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(ctrData.dates(i),datenum(daysPBS))
%             ctrData.colorByCondition{i} = 'b';
%             ctrData.conditionNum(i) = 1;
%         elseif ismember(ctrData.dates(i),datenum(daysCNO))
%             ctrData.colorByCondition{i} = 'r';
%             ctrData.conditionNum(i) = 2;
%         elseif ismember(ctrData.dates(i),datenum(daysIntact))
%             ctrData.colorByCondition{i} = 'b';
%             ctrData.conditionNum(i) = 3;
%         elseif ismember(ctrData.dates(i),datenum(daysLesion))
%             ctrData.colorByCondition{i} = 'r';
%             ctrData.conditionNum(i) = 4;
%         else
%             ctrData.colorByCondition{i} = 'k';
%             ctrData.conditionNum(i) = 5;
%         end
%                 
%         if ctrData.conditionNum(i) == 1
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,1} = [ctrData.trialNumsByCondition{j,1} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,1) = ctrData.numTrialsByCondition(j,1)+n1;
%                 ctrData.correctByCondition(j,1) = ctrData.correctByCondition(j,1)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,1} = [ctrData.trialNumsByConditionWCO{j,1} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,1) = ctrData.numTrialsByConditionWCO(j,1)+n1;
%                     ctrData.correctByConditionWCO(j,1) = ctrData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 2
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,2} = [ctrData.trialNumsByCondition{j,2} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,2) = ctrData.numTrialsByCondition(j,2)+n1;
%                 ctrData.correctByCondition(j,2) = ctrData.correctByCondition(j,2)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,2} = [ctrData.trialNumsByConditionWCO{j,2} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,2) = ctrData.numTrialsByConditionWCO(j,2)+n1;
%                     ctrData.correctByConditionWCO(j,2) = ctrData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 3
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,3} = [ctrData.trialNumsByCondition{j,3} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,3) = ctrData.numTrialsByCondition(j,3)+n1;
%                 ctrData.correctByCondition(j,3) = ctrData.correctByCondition(j,3)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,3} = [ctrData.trialNumsByConditionWCO{j,3} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,3) = ctrData.numTrialsByConditionWCO(j,3)+n1;
%                     ctrData.correctByConditionWCO(j,3) = ctrData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 4
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,4} = [ctrData.trialNumsByCondition{j,4} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,4) = ctrData.numTrialsByCondition(j,4)+n1;
%                 ctrData.correctByCondition(j,4) = ctrData.correctByCondition(j,4)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,4} = [ctrData.trialNumsByConditionWCO{j,4} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,4) = ctrData.numTrialsByConditionWCO(j,4)+n1;
%                     ctrData.correctByConditionWCO(j,4) = ctrData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 5
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,5} = [ctrData.trialNumsByCondition{j,5} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,5) = ctrData.numTrialsByCondition(j,5)+n1;
%                 ctrData.correctByCondition(j,5) = ctrData.correctByCondition(j,5)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,5} = [ctrData.trialNumsByConditionWCO{j,5} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,5) = ctrData.numTrialsByConditionWCO(j,5)+n1;
%                     ctrData.correctByConditionWCO(j,5) = ctrData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(ctrData.contrasts)
%     [phat,pci] = binofit(ctrData.correctByCondition(j,:),ctrData.numTrialsByCondition(j,:));
%     ctrData.performanceByCondition(j,1,:) = phat;
%     ctrData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([ctrData.correctByConditionWCO(j,:)],[ctrData.numTrialsByConditionWCO(j,:)]);
%     ctrData.performanceByConditionWCO(j,1,:) = phat;
%     ctrData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(ctrData.trialNum)
%     figName = sprintf('%s::VARIABLE CONTRAST',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(ctrData.dates-min(ctrData.dates)+1,ctrData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(ctrData.dates)-min(ctrData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(ctrData.dates)-min(ctrData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(ctrData.dates)
%         if ~isnan(ctrData.dayMetCutOffCriterion(i))
%             if ctrData.dayMetCutOffCriterion(i)
%                 xloc = ctrData.dates(i)-min(ctrData.dates)+1;
%                 plot(xloc,ctrData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],ctrData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = ctrData.dates(i)-min(ctrData.dates)+1;
%                 plot(xloc,ctrData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],ctrData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = ctrData.dates(i)-min(ctrData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(ctrData.performanceByConditionWCO,3)
%         for j = 1:size(ctrData.performanceByConditionWCO,1)
%             if ~isnan(ctrData.performanceByConditionWCO(j,1,i))
%                 plot(ctrData.contrasts(j),ctrData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([ctrData.contrasts(j) ctrData.contrasts(j)],[ctrData.performanceByConditionWCO(j,2,i) ctrData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     set(ax3,'ylim',[0.2 1.1],'xlim',[0 1],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
%     xlabel('contrast','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.ctrData = ctrData;
% 
% %% CONTRAST REVERSAL
% ctr1 = [];
% ctrData = [];
% ctr1 = filterBehaviorData(data1,'tsName','orCTRSweep_Reversal_nAFC');%1x3453 trials 
% ctrData.trialNum = [ctr1.compiledTrialRecords.trialNumber];
% ctrData.correct = [ctr1.compiledTrialRecords.correct];
% ctrData.correction = [ctr1.compiledTrialRecords.correctionTrial];
% ctrData.contrast = [ctr1.compiledDetails(2).records.contrasts];
% ctrData.time = [ctr1.compiledTrialRecords.date];
% ctrData.date = floor(ctrData.time);
% ctrData.dates = unique(ctrData.date);
% ctrData.contrasts = unique(ctrData.contrast);
% 
% % performance on a day by day basis
% ctrData.trialNumByDate = cell(1,length(ctrData.dates));
% ctrData.numTrialsByDate = nan(1,length(ctrData.dates));
% ctrData.performanceByDate = nan(3,length(ctrData.dates));
% ctrData.colorByCondition = cell(1,length(ctrData.dates));
% ctrData.conditionNum = nan(1,length(ctrData.dates));
% ctrData.dayMetCutOffCriterion = nan(1,length(ctrData.dates));
% 
% %performance by condition
% ctrData.trialNumsByCondition = cell(length(ctrData.contrasts),5);
% ctrData.numTrialsByCondition = zeros(length(ctrData.contrasts),5);
% ctrData.correctByCondition = zeros(length(ctrData.contrasts),5);
% ctrData.performanceByCondition = nan(length(ctrData.contrasts),3,5);
% 
% %performance by condition with trial number cutoff
% ctrData.trialNumsByConditionWCO = cell(length(ctrData.contrasts),5);
% ctrData.numTrialsByConditionWCO = zeros(length(ctrData.contrasts),5);
% ctrData.correctByConditionWCO = zeros(length(ctrData.contrasts),5);
% ctrData.performanceByConditionWCO = nan(length(ctrData.contrasts),3,5);
% 
% for i = 1:length(ctrData.dates)
%     if ismember(ctrData.dates(i),filters.ctrRevFilter)
%         dateFilter = ctrData.date==ctrData.dates(i);
%         correctThatDate = ctrData.correct(dateFilter);
%         correctionThatDate = ctrData.correction(dateFilter);
%         contrastThatDate = ctrData.contrast(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         contrastThatDate = contrastThatDate(whichGood);
%  
%         ctrData.trialNumByDate{i} = ctrData.trialNum(dateFilter);
%         ctrData.trialNumByDate{i} = ctrData.trialNumByDate{i}(whichGood);
%         ctrData.numTrialsByDate(i) = length(ctrData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         ctrData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         ctrData.performanceByDate(1,i) = phat;
%         ctrData.performanceByDate(2,i) = pci(1);
%         ctrData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(ctrData.dates(i),datenum(daysPBS))
%             ctrData.colorByCondition{i} = 'b';
%             ctrData.conditionNum(i) = 1;
%         elseif ismember(ctrData.dates(i),datenum(daysCNO))
%             ctrData.colorByCondition{i} = 'r';
%             ctrData.conditionNum(i) = 2;
%         elseif ismember(ctrData.dates(i),datenum(daysIntact))
%             ctrData.colorByCondition{i} = 'b';
%             ctrData.conditionNum(i) = 3;
%         elseif ismember(ctrData.dates(i),datenum(daysLesion))
%             ctrData.colorByCondition{i} = 'r';
%             ctrData.conditionNum(i) = 4;
%         else
%             ctrData.colorByCondition{i} = 'k';
%             ctrData.conditionNum(i) = 5;
%         end
%                 
%         if ctrData.conditionNum(i) == 1
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,1} = [ctrData.trialNumsByCondition{j,1} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,1) = ctrData.numTrialsByCondition(j,1)+n1;
%                 ctrData.correctByCondition(j,1) = ctrData.correctByCondition(j,1)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,1} = [ctrData.trialNumsByConditionWCO{j,1} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,1) = ctrData.numTrialsByConditionWCO(j,1)+n1;
%                     ctrData.correctByConditionWCO(j,1) = ctrData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 2
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,2} = [ctrData.trialNumsByCondition{j,2} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,2) = ctrData.numTrialsByCondition(j,2)+n1;
%                 ctrData.correctByCondition(j,2) = ctrData.correctByCondition(j,2)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,2} = [ctrData.trialNumsByConditionWCO{j,2} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,2) = ctrData.numTrialsByConditionWCO(j,2)+n1;
%                     ctrData.correctByConditionWCO(j,2) = ctrData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 3
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,3} = [ctrData.trialNumsByCondition{j,3} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,3) = ctrData.numTrialsByCondition(j,3)+n1;
%                 ctrData.correctByCondition(j,3) = ctrData.correctByCondition(j,3)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,3} = [ctrData.trialNumsByConditionWCO{j,3} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,3) = ctrData.numTrialsByConditionWCO(j,3)+n1;
%                     ctrData.correctByConditionWCO(j,3) = ctrData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 4
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,4} = [ctrData.trialNumsByCondition{j,4} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,4) = ctrData.numTrialsByCondition(j,4)+n1;
%                 ctrData.correctByCondition(j,4) = ctrData.correctByCondition(j,4)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,4} = [ctrData.trialNumsByConditionWCO{j,4} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,4) = ctrData.numTrialsByConditionWCO(j,4)+n1;
%                     ctrData.correctByConditionWCO(j,4) = ctrData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif ctrData.conditionNum(i) == 5
%             for j = 1:length(ctrData.contrasts)
%                 whichCurrContrast = contrastThatDate==ctrData.contrasts(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 ctrData.trialNumsByCondition{j,5} = [ctrData.trialNumsByCondition{j,5} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                 ctrData.numTrialsByCondition(j,5) = ctrData.numTrialsByCondition(j,5)+n1;
%                 ctrData.correctByCondition(j,5) = ctrData.correctByCondition(j,5)+x1;
%                 if ctrData.dayMetCutOffCriterion(i)
%                     ctrData.trialNumsByConditionWCO{j,5} = [ctrData.trialNumsByConditionWCO{j,5} makerow(ctrData.trialNumByDate{i}(whichCurrContrast))];
%                     ctrData.numTrialsByConditionWCO(j,5) = ctrData.numTrialsByConditionWCO(j,5)+n1;
%                     ctrData.correctByConditionWCO(j,5) = ctrData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(ctrData.contrasts)
%     [phat,pci] = binofit(ctrData.correctByCondition(j,:),ctrData.numTrialsByCondition(j,:));
%     ctrData.performanceByCondition(j,1,:) = phat;
%     ctrData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([ctrData.correctByConditionWCO(j,:)],[ctrData.numTrialsByConditionWCO(j,:)]);
%     ctrData.performanceByConditionWCO(j,1,:) = phat;
%     ctrData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(ctrData.trialNum)
%     figName = sprintf('%s::VARIABLE CONTRAST REVERSAL',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(ctrData.dates-min(ctrData.dates)+1,ctrData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(ctrData.dates)-min(ctrData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(ctrData.dates)-min(ctrData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(ctrData.dates)
%         if ~isnan(ctrData.dayMetCutOffCriterion(i))
%             if ctrData.dayMetCutOffCriterion(i)
%                 xloc = ctrData.dates(i)-min(ctrData.dates)+1;
%                 plot(xloc,ctrData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],ctrData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = ctrData.dates(i)-min(ctrData.dates)+1;
%                 plot(xloc,ctrData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],ctrData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = ctrData.dates(i)-min(ctrData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(ctrData.performanceByConditionWCO,3)
%         for j = 1:size(ctrData.performanceByConditionWCO,1)
%             if ~isnan(ctrData.performanceByConditionWCO(j,1,i))
%                 plot(ctrData.contrasts(j),ctrData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([ctrData.contrasts(j) ctrData.contrasts(j)],[ctrData.performanceByConditionWCO(j,2,i) ctrData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     set(ax3,'ylim',[0.2 1.1],'xlim',[0 1],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
%     xlabel('contrast','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.ctrRevData = ctrData;
% 
% %% SPAT FREQ
% spat = filterBehaviorData(data1,'tsName','orSFSweep');%1x1072 trials 
% spatData.trialNum = [spat.compiledTrialRecords.trialNumber];
% spatData.correct = [spat.compiledTrialRecords.correct];
% spatData.correction = [spat.compiledTrialRecords.correctionTrial];
% spatData.spatFreq = [spat.compiledDetails(2).records.pixPerCycs];
% spatData.time = [spat.compiledTrialRecords.date];
% spatData.date = floor(spatData.time);
% spatData.dates = unique(spatData.date);
% spatData.spatFreqs = unique(spatData.spatFreq);
% 
% % performance on a day by day basis
% spatData.trialNumByDate = cell(1,length(spatData.dates));
% spatData.numTrialsByDate = nan(1,length(spatData.dates));
% spatData.performanceByDate = nan(3,length(spatData.dates));
% spatData.colorByCondition = cell(1,length(spatData.dates));
% spatData.conditionNum = nan(1,length(spatData.dates));
% spatData.dayMetCutOffCriterion = nan(1,length(spatData.dates));
% 
% %performance by condition
% spatData.trialNumsByCondition = cell(length(spatData.spatFreqs),5);
% spatData.numTrialsByCondition = zeros(length(spatData.spatFreqs),5);
% spatData.correctByCondition = zeros(length(spatData.spatFreqs),5);
% spatData.performanceByCondition = nan(length(spatData.spatFreqs),3,5);
% 
% %performance by condition with trial number cutoff
% spatData.trialNumsByConditionWCO = cell(length(spatData.spatFreqs),5);
% spatData.numTrialsByConditionWCO = zeros(length(spatData.spatFreqs),5);
% spatData.correctByConditionWCO = zeros(length(spatData.spatFreqs),5);
% spatData.performanceByConditionWCO = nan(length(spatData.spatFreqs),3,5);
% 
% for i = 1:length(spatData.dates)
%     if ismember(spatData.dates(i),filters.sfFilter)
%         dateFilter = spatData.date==spatData.dates(i);
%         correctThatDate = spatData.correct(dateFilter);
%         correctionThatDate = spatData.correction(dateFilter);
%         sfThatDate = spatData.spatFreq(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         sfThatDate = sfThatDate(whichGood);
%  
%         spatData.trialNumByDate{i} = spatData.trialNum(dateFilter);
%         spatData.trialNumByDate{i} = spatData.trialNumByDate{i}(whichGood);
%         spatData.numTrialsByDate(i) = length(spatData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         spatData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         spatData.performanceByDate(1,i) = phat;
%         spatData.performanceByDate(2,i) = pci(1);
%         spatData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(spatData.dates(i),datenum(daysPBS))
%             spatData.colorByCondition{i} = 'b';
%             spatData.conditionNum(i) = 1;
%         elseif ismember(spatData.dates(i),datenum(daysCNO))
%             spatData.colorByCondition{i} = 'r';
%             spatData.conditionNum(i) = 2;
%         elseif ismember(spatData.dates(i),datenum(daysIntact))
%             spatData.colorByCondition{i} = 'b';
%             spatData.conditionNum(i) = 3;
%         elseif ismember(spatData.dates(i),datenum(daysLesion))
%             spatData.colorByCondition{i} = 'r';
%             spatData.conditionNum(i) = 4;
%         else
%             spatData.colorByCondition{i} = 'k';
%             spatData.conditionNum(i) = 5;
%         end
%                 
%         if spatData.conditionNum(i) == 1
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,1} = [spatData.trialNumsByCondition{j,1} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,1) = spatData.numTrialsByCondition(j,1)+n1;
%                 spatData.correctByCondition(j,1) = spatData.correctByCondition(j,1)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,1} = [spatData.trialNumsByConditionWCO{j,1} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,1) = spatData.numTrialsByConditionWCO(j,1)+n1;
%                     spatData.correctByConditionWCO(j,1) = spatData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 2
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,2} = [spatData.trialNumsByCondition{j,2} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,2) = spatData.numTrialsByCondition(j,2)+n1;
%                 spatData.correctByCondition(j,2) = spatData.correctByCondition(j,2)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,2} = [spatData.trialNumsByConditionWCO{j,2} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,2) = spatData.numTrialsByConditionWCO(j,2)+n1;
%                     spatData.correctByConditionWCO(j,2) = spatData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 3
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,3} = [spatData.trialNumsByCondition{j,3} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,3) = spatData.numTrialsByCondition(j,3)+n1;
%                 spatData.correctByCondition(j,3) = spatData.correctByCondition(j,3)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,3} = [spatData.trialNumsByConditionWCO{j,3} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,3) = spatData.numTrialsByConditionWCO(j,3)+n1;
%                     spatData.correctByConditionWCO(j,3) = spatData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 4
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,4} = [spatData.trialNumsByCondition{j,4} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,4) = spatData.numTrialsByCondition(j,4)+n1;
%                 spatData.correctByCondition(j,4) = spatData.correctByCondition(j,4)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,4} = [spatData.trialNumsByConditionWCO{j,4} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,4) = spatData.numTrialsByConditionWCO(j,4)+n1;
%                     spatData.correctByConditionWCO(j,4) = spatData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 5
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,5} = [spatData.trialNumsByCondition{j,5} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,5) = spatData.numTrialsByCondition(j,5)+n1;
%                 spatData.correctByCondition(j,5) = spatData.correctByCondition(j,5)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,5} = [spatData.trialNumsByConditionWCO{j,5} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,5) = spatData.numTrialsByConditionWCO(j,5)+n1;
%                     spatData.correctByConditionWCO(j,5) = spatData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(spatData.spatFreqs)
%     [phat,pci] = binofit(spatData.correctByCondition(j,:),spatData.numTrialsByCondition(j,:));
%     spatData.performanceByCondition(j,1,:) = phat;
%     spatData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([spatData.correctByConditionWCO(j,:)],[spatData.numTrialsByConditionWCO(j,:)]);
%     spatData.performanceByConditionWCO(j,1,:) = phat;
%     spatData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(spatData.trialNum)
%     figName = sprintf('%s::VARIABLE SF',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(spatData.dates-min(spatData.dates)+1,spatData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(spatData.dates)-min(spatData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(spatData.dates)-min(spatData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(spatData.dates)
%         if ~isnan(spatData.dayMetCutOffCriterion(i))
%             if spatData.dayMetCutOffCriterion(i)
%                 xloc = spatData.dates(i)-min(spatData.dates)+1;
%                 plot(xloc,spatData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],spatData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = spatData.dates(i)-min(spatData.dates)+1;
%                 plot(xloc,spatData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],spatData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = spatData.dates(i)-min(spatData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(spatData.performanceByConditionWCO,3)
%         for j = 1:size(spatData.performanceByConditionWCO,1)
%             if ~isnan(spatData.performanceByConditionWCO(j,1,i))
%                 xloc = log10(1/rad2deg(atan(44.7/1024*spatData.spatFreqs(j)/12)));
% %                 xloc = 1/spatData.spatFreqs(j);
%                 plot(xloc,spatData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([xloc xloc],[spatData.performanceByConditionWCO(j,2,i) spatData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     xticks = log10([0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.2]);
%     xticklabs = {'0.01','','','','','','','','','0.1','0.2'};
%     set(ax3,'ylim',[0.2 1.1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12,'xlim',[log10(0.0075) log10(0.25)],'xtick',xticks,'xticklabel',xticklabs);plot(get(gca,'xlim'),[0.5 0.5],'k-');plot(get(gca,'xlim'),[0.7 0.7],'k--');
%     xlabel('spat.freq.','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.spatData = spatData;
% 
% %% SPAT FREQ REVERSAL
% spat = [];
% spatData = [];
% spat = filterBehaviorData(data1,'tsName','orSFSweep_Reversal_nAFC');
% spatData.trialNum = [spat.compiledTrialRecords.trialNumber];
% spatData.correct = [spat.compiledTrialRecords.correct];
% spatData.correction = [spat.compiledTrialRecords.correctionTrial];
% spatData.spatFreq = [spat.compiledDetails(2).records.pixPerCycs];
% spatData.time = [spat.compiledTrialRecords.date];
% spatData.date = floor(spatData.time);
% spatData.dates = unique(spatData.date);
% spatData.spatFreqs = unique(spatData.spatFreq);
% 
% % performance on a day by day basis
% spatData.trialNumByDate = cell(1,length(spatData.dates));
% spatData.numTrialsByDate = nan(1,length(spatData.dates));
% spatData.performanceByDate = nan(3,length(spatData.dates));
% spatData.colorByCondition = cell(1,length(spatData.dates));
% spatData.conditionNum = nan(1,length(spatData.dates));
% spatData.dayMetCutOffCriterion = nan(1,length(spatData.dates));
% 
% %performance by condition
% spatData.trialNumsByCondition = cell(length(spatData.spatFreqs),5);
% spatData.numTrialsByCondition = zeros(length(spatData.spatFreqs),5);
% spatData.correctByCondition = zeros(length(spatData.spatFreqs),5);
% spatData.performanceByCondition = nan(length(spatData.spatFreqs),3,5);
% 
% %performance by condition with trial number cutoff
% spatData.trialNumsByConditionWCO = cell(length(spatData.spatFreqs),5);
% spatData.numTrialsByConditionWCO = zeros(length(spatData.spatFreqs),5);
% spatData.correctByConditionWCO = zeros(length(spatData.spatFreqs),5);
% spatData.performanceByConditionWCO = nan(length(spatData.spatFreqs),3,5);
% 
% for i = 1:length(spatData.dates)
%     if ismember(spatData.dates(i),filters.sfRevFilter)
%         dateFilter = spatData.date==spatData.dates(i);
%         correctThatDate = spatData.correct(dateFilter);
%         correctionThatDate = spatData.correction(dateFilter);
%         sfThatDate = spatData.spatFreq(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         sfThatDate = sfThatDate(whichGood);
%  
%         spatData.trialNumByDate{i} = spatData.trialNum(dateFilter);
%         spatData.trialNumByDate{i} = spatData.trialNumByDate{i}(whichGood);
%         spatData.numTrialsByDate(i) = length(spatData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         spatData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         spatData.performanceByDate(1,i) = phat;
%         spatData.performanceByDate(2,i) = pci(1);
%         spatData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(spatData.dates(i),datenum(daysPBS))
%             spatData.colorByCondition{i} = 'b';
%             spatData.conditionNum(i) = 1;
%         elseif ismember(spatData.dates(i),datenum(daysCNO))
%             spatData.colorByCondition{i} = 'r';
%             spatData.conditionNum(i) = 2;
%         elseif ismember(spatData.dates(i),datenum(daysIntact))
%             spatData.colorByCondition{i} = 'b';
%             spatData.conditionNum(i) = 3;
%         elseif ismember(spatData.dates(i),datenum(daysLesion))
%             spatData.colorByCondition{i} = 'r';
%             spatData.conditionNum(i) = 4;
%         else
%             spatData.colorByCondition{i} = 'k';
%             spatData.conditionNum(i) = 5;
%         end
%                 
%         if spatData.conditionNum(i) == 1
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,1} = [spatData.trialNumsByCondition{j,1} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,1) = spatData.numTrialsByCondition(j,1)+n1;
%                 spatData.correctByCondition(j,1) = spatData.correctByCondition(j,1)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,1} = [spatData.trialNumsByConditionWCO{j,1} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,1) = spatData.numTrialsByConditionWCO(j,1)+n1;
%                     spatData.correctByConditionWCO(j,1) = spatData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 2
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,2} = [spatData.trialNumsByCondition{j,2} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,2) = spatData.numTrialsByCondition(j,2)+n1;
%                 spatData.correctByCondition(j,2) = spatData.correctByCondition(j,2)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,2} = [spatData.trialNumsByConditionWCO{j,2} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,2) = spatData.numTrialsByConditionWCO(j,2)+n1;
%                     spatData.correctByConditionWCO(j,2) = spatData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 3
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,3} = [spatData.trialNumsByCondition{j,3} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,3) = spatData.numTrialsByCondition(j,3)+n1;
%                 spatData.correctByCondition(j,3) = spatData.correctByCondition(j,3)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,3} = [spatData.trialNumsByConditionWCO{j,3} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,3) = spatData.numTrialsByConditionWCO(j,3)+n1;
%                     spatData.correctByConditionWCO(j,3) = spatData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 4
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,4} = [spatData.trialNumsByCondition{j,4} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,4) = spatData.numTrialsByCondition(j,4)+n1;
%                 spatData.correctByCondition(j,4) = spatData.correctByCondition(j,4)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,4} = [spatData.trialNumsByConditionWCO{j,4} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,4) = spatData.numTrialsByConditionWCO(j,4)+n1;
%                     spatData.correctByConditionWCO(j,4) = spatData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif spatData.conditionNum(i) == 5
%             for j = 1:length(spatData.spatFreqs)
%                 whichCurrContrast = sfThatDate==spatData.spatFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 spatData.trialNumsByCondition{j,5} = [spatData.trialNumsByCondition{j,5} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                 spatData.numTrialsByCondition(j,5) = spatData.numTrialsByCondition(j,5)+n1;
%                 spatData.correctByCondition(j,5) = spatData.correctByCondition(j,5)+x1;
%                 if spatData.dayMetCutOffCriterion(i)
%                     spatData.trialNumsByConditionWCO{j,5} = [spatData.trialNumsByConditionWCO{j,5} makerow(spatData.trialNumByDate{i}(whichCurrContrast))];
%                     spatData.numTrialsByConditionWCO(j,5) = spatData.numTrialsByConditionWCO(j,5)+n1;
%                     spatData.correctByConditionWCO(j,5) = spatData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(spatData.spatFreqs)
%     [phat,pci] = binofit(spatData.correctByCondition(j,:),spatData.numTrialsByCondition(j,:));
%     spatData.performanceByCondition(j,1,:) = phat;
%     spatData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([spatData.correctByConditionWCO(j,:)],[spatData.numTrialsByConditionWCO(j,:)]);
%     spatData.performanceByConditionWCO(j,1,:) = phat;
%     spatData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(spatData.trialNum)
%     figName = sprintf('%s::VARIABLE SF REVERSAL',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(spatData.dates-min(spatData.dates)+1,spatData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(spatData.dates)-min(spatData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(spatData.dates)-min(spatData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(spatData.dates)
%         if ~isnan(spatData.dayMetCutOffCriterion(i))
%             if spatData.dayMetCutOffCriterion(i)
%                 xloc = spatData.dates(i)-min(spatData.dates)+1;
%                 plot(xloc,spatData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],spatData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = spatData.dates(i)-min(spatData.dates)+1;
%                 plot(xloc,spatData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],spatData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = spatData.dates(i)-min(spatData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(spatData.performanceByConditionWCO,3)
%         for j = 1:size(spatData.performanceByConditionWCO,1)
%             if ~isnan(spatData.performanceByConditionWCO(j,1,i))
%                 xloc = log10(1/rad2deg(atan(44.7/1024*spatData.spatFreqs(j)/12)));
% %                 xloc = 1/spatData.spatFreqs(j);
%                 plot(xloc,spatData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([xloc xloc],[spatData.performanceByConditionWCO(j,2,i) spatData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     xticks = log10([0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.2]);
%     xticklabs = {'0.01','','','','','','','','','0.1','0.2'};
%     set(ax3,'ylim',[0.2 1.1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12,'xlim',[log10(0.0075) log10(0.25)],'xtick',xticks,'xticklabel',xticklabs);plot(get(gca,'xlim'),[0.5 0.5],'k-');plot(get(gca,'xlim'),[0.7 0.7],'k--');
%     xlabel('spat.freq.','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.spatRevData = spatData;
% 
% %% TEMP FREQ
% temp = filterBehaviorData(data1,'tsName','orTFSweep_nAFC');%1x1072 trials 
% tempData.trialNum = [temp.compiledTrialRecords.trialNumber];
% tempData.correct = [temp.compiledTrialRecords.correct];
% tempData.correction = [temp.compiledTrialRecords.correctionTrial];
% tempData.tempFreq = [temp.compiledDetails(2).records.driftfrequencies];
% whichZero = tempData.tempFreq==0;
% tempData.tempFreq(whichZero) = 0.1;
% tempData.time = [temp.compiledTrialRecords.date];
% tempData.date = floor(tempData.time);
% tempData.dates = unique(tempData.date);
% tempData.tempFreqs = unique(tempData.tempFreq);
% 
% % performance on a day by day basis
% tempData.trialNumByDate = cell(1,length(tempData.dates));
% tempData.numTrialsByDate = nan(1,length(tempData.dates));
% tempData.performanceByDate = nan(3,length(tempData.dates));
% tempData.colorByCondition = cell(1,length(tempData.dates));
% tempData.conditionNum = nan(1,length(tempData.dates));
% tempData.dayMetCutOffCriterion = nan(1,length(tempData.dates));
% 
% %performance by condition
% tempData.trialNumsByCondition = cell(length(tempData.tempFreq),5);
% tempData.numTrialsByCondition = zeros(length(tempData.tempFreqs),5);
% tempData.correctByCondition = zeros(length(tempData.tempFreqs),5);
% tempData.performanceByCondition = nan(length(tempData.tempFreqs),3,5);
% 
% %performance by condition with trial number cutoff
% tempData.trialNumsByConditionWCO = cell(length(tempData.tempFreqs),5);
% tempData.numTrialsByConditionWCO = zeros(length(tempData.tempFreqs),5);
% tempData.correctByConditionWCO = zeros(length(tempData.tempFreqs),5);
% tempData.performanceByConditionWCO = nan(length(tempData.tempFreqs),3,5);
% 
% for i = 1:length(tempData.dates)
%     if ismember(tempData.dates(i),filters.tfFilter)
%         dateFilter = tempData.date==tempData.dates(i);
%         correctThatDate = tempData.correct(dateFilter);
%         correctionThatDate = tempData.correction(dateFilter);
%         tfThatDate = tempData.tempFreq(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         tfThatDate = tfThatDate(whichGood);
%  
%         tempData.trialNumByDate{i} = tempData.trialNum(dateFilter);
%         tempData.trialNumByDate{i} = tempData.trialNumByDate{i}(whichGood);
%         tempData.numTrialsByDate(i) = length(tempData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         tempData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         tempData.performanceByDate(1,i) = phat;
%         tempData.performanceByDate(2,i) = pci(1);
%         tempData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(tempData.dates(i),datenum(daysPBS))
%             tempData.colorByCondition{i} = 'b';
%             tempData.conditionNum(i) = 1;
%         elseif ismember(tempData.dates(i),datenum(daysCNO))
%             tempData.colorByCondition{i} = 'r';
%             tempData.conditionNum(i) = 2;
%         elseif ismember(tempData.dates(i),datenum(daysIntact))
%             tempData.colorByCondition{i} = 'b';
%             tempData.conditionNum(i) = 3;
%         elseif ismember(tempData.dates(i),datenum(daysLesion))
%             tempData.colorByCondition{i} = 'r';
%             tempData.conditionNum(i) = 4;
%         else
%             tempData.colorByCondition{i} = 'k';
%             tempData.conditionNum(i) = 5;
%         end
%                 
%         if tempData.conditionNum(i) == 1
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,1} = [tempData.trialNumsByCondition{j,1} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,1) = tempData.numTrialsByCondition(j,1)+n1;
%                 tempData.correctByCondition(j,1) = tempData.correctByCondition(j,1)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,1} = [tempData.trialNumsByConditionWCO{j,1} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,1) = tempData.numTrialsByConditionWCO(j,1)+n1;
%                     tempData.correctByConditionWCO(j,1) = tempData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 2
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,2} = [tempData.trialNumsByCondition{j,2} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,2) = tempData.numTrialsByCondition(j,2)+n1;
%                 tempData.correctByCondition(j,2) = tempData.correctByCondition(j,2)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,2} = [tempData.trialNumsByConditionWCO{j,2} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,2) = tempData.numTrialsByConditionWCO(j,2)+n1;
%                     tempData.correctByConditionWCO(j,2) = tempData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 3
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,3} = [tempData.trialNumsByCondition{j,3} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,3) = tempData.numTrialsByCondition(j,3)+n1;
%                 tempData.correctByCondition(j,3) = tempData.correctByCondition(j,3)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,3} = [tempData.trialNumsByConditionWCO{j,3} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,3) = tempData.numTrialsByConditionWCO(j,3)+n1;
%                     tempData.correctByConditionWCO(j,3) = tempData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 4
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,4} = [tempData.trialNumsByCondition{j,4} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,4) = tempData.numTrialsByCondition(j,4)+n1;
%                 tempData.correctByCondition(j,4) = tempData.correctByCondition(j,4)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,4} = [tempData.trialNumsByConditionWCO{j,4} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,4) = tempData.numTrialsByConditionWCO(j,4)+n1;
%                     tempData.correctByConditionWCO(j,4) = tempData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 5
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,5} = [tempData.trialNumsByCondition{j,5} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,5) = tempData.numTrialsByCondition(j,5)+n1;
%                 tempData.correctByCondition(j,5) = tempData.correctByCondition(j,5)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,5} = [tempData.trialNumsByConditionWCO{j,5} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,5) = tempData.numTrialsByConditionWCO(j,5)+n1;
%                     tempData.correctByConditionWCO(j,5) = tempData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(tempData.tempFreqs)
%     [phat,pci] = binofit(tempData.correctByCondition(j,:),tempData.numTrialsByCondition(j,:));
%     tempData.performanceByCondition(j,1,:) = phat;
%     tempData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([tempData.correctByConditionWCO(j,:)],[tempData.numTrialsByConditionWCO(j,:)]);
%     tempData.performanceByConditionWCO(j,1,:) = phat;
%     tempData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(tempData.trialNum)
%     figName = sprintf('%s::VARIABLE TF',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(tempData.dates-min(tempData.dates)+1,tempData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(tempData.dates)-min(tempData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(tempData.dates)-min(tempData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(tempData.dates)
%         if ~isnan(tempData.dayMetCutOffCriterion(i))
%             if tempData.dayMetCutOffCriterion(i)
%                 xloc = tempData.dates(i)-min(tempData.dates)+1;
%                 plot(xloc,tempData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],tempData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = tempData.dates(i)-min(tempData.dates)+1;
%                 plot(xloc,tempData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],tempData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = tempData.dates(i)-min(tempData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(tempData.performanceByConditionWCO,3)
%         for j = 1:size(tempData.performanceByConditionWCO,1)
%             if ~isnan(tempData.performanceByConditionWCO(j,1,i))
%                 xloc = log2(tempData.tempFreqs(j));
%                 plot(xloc,tempData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([xloc xloc],[tempData.performanceByConditionWCO(j,2,i) tempData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     xticks = log2([0.0625 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20]);
%     xticklabs = {'','0','','','','','','','','','1','','','','','','','','','10',''};
%     set(ax3,'ylim',[0.2 1.1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12,'xlim',log2([0.0625 32]),'xtick',xticks,'xticklabel',xticklabs);plot(get(gca,'xlim'),[0.5 0.5],'k-');plot(get(gca,'xlim'),[0.7 0.7],'k--');
%     xlabel('temp.freq.','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.tempData = tempData;
% 
% %% TEMP FREQ REVERSAL
% temp = [];
% tempData = [];
% temp = filterBehaviorData(data1,'tsName','orTFSweep_Reversal_nAFC');
% tempData.trialNum = [temp.compiledTrialRecords.trialNumber];
% tempData.correct = [temp.compiledTrialRecords.correct];
% tempData.correction = [temp.compiledTrialRecords.correctionTrial];
% tempData.tempFreq = [temp.compiledDetails(2).records.driftfrequencies];
% whichZero = tempData.tempFreq==0;
% tempData.tempFreq(whichZero) = 0.1;
% tempData.time = [temp.compiledTrialRecords.date];
% tempData.date = floor(tempData.time);
% tempData.dates = unique(tempData.date);
% tempData.tempFreqs = unique(tempData.tempFreq);
% 
% % performance on a day by day basis
% tempData.trialNumByDate = cell(1,length(tempData.dates));
% tempData.numTrialsByDate = nan(1,length(tempData.dates));
% tempData.performanceByDate = nan(3,length(tempData.dates));
% tempData.colorByCondition = cell(1,length(tempData.dates));
% tempData.conditionNum = nan(1,length(tempData.dates));
% tempData.dayMetCutOffCriterion = nan(1,length(tempData.dates));
% 
% %performance by condition
% tempData.trialNumsByCondition = cell(length(tempData.tempFreq),5);
% tempData.numTrialsByCondition = zeros(length(tempData.tempFreqs),5);
% tempData.correctByCondition = zeros(length(tempData.tempFreqs),5);
% tempData.performanceByCondition = nan(length(tempData.tempFreqs),3,5);
% 
% %performance by condition with trial number cutoff
% tempData.trialNumsByConditionWCO = cell(length(tempData.tempFreqs),5);
% tempData.numTrialsByConditionWCO = zeros(length(tempData.tempFreqs),5);
% tempData.correctByConditionWCO = zeros(length(tempData.tempFreqs),5);
% tempData.performanceByConditionWCO = nan(length(tempData.tempFreqs),3,5);
% 
% for i = 1:length(tempData.dates)
%     if ismember(tempData.dates(i),filters.tfRevFilter)
%         dateFilter = tempData.date==tempData.dates(i);
%         correctThatDate = tempData.correct(dateFilter);
%         correctionThatDate = tempData.correction(dateFilter);
%         tfThatDate = tempData.tempFreq(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         tfThatDate = tfThatDate(whichGood);
%  
%         tempData.trialNumByDate{i} = tempData.trialNum(dateFilter);
%         tempData.trialNumByDate{i} = tempData.trialNumByDate{i}(whichGood);
%         tempData.numTrialsByDate(i) = length(tempData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         tempData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         tempData.performanceByDate(1,i) = phat;
%         tempData.performanceByDate(2,i) = pci(1);
%         tempData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(tempData.dates(i),datenum(daysPBS))
%             tempData.colorByCondition{i} = 'b';
%             tempData.conditionNum(i) = 1;
%         elseif ismember(tempData.dates(i),datenum(daysCNO))
%             tempData.colorByCondition{i} = 'r';
%             tempData.conditionNum(i) = 2;
%         elseif ismember(tempData.dates(i),datenum(daysIntact))
%             tempData.colorByCondition{i} = 'b';
%             tempData.conditionNum(i) = 3;
%         elseif ismember(tempData.dates(i),datenum(daysLesion))
%             tempData.colorByCondition{i} = 'r';
%             tempData.conditionNum(i) = 4;
%         else
%             tempData.colorByCondition{i} = 'k';
%             tempData.conditionNum(i) = 5;
%         end
%                 
%         if tempData.conditionNum(i) == 1
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,1} = [tempData.trialNumsByCondition{j,1} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,1) = tempData.numTrialsByCondition(j,1)+n1;
%                 tempData.correctByCondition(j,1) = tempData.correctByCondition(j,1)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,1} = [tempData.trialNumsByConditionWCO{j,1} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,1) = tempData.numTrialsByConditionWCO(j,1)+n1;
%                     tempData.correctByConditionWCO(j,1) = tempData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 2
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,2} = [tempData.trialNumsByCondition{j,2} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,2) = tempData.numTrialsByCondition(j,2)+n1;
%                 tempData.correctByCondition(j,2) = tempData.correctByCondition(j,2)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,2} = [tempData.trialNumsByConditionWCO{j,2} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,2) = tempData.numTrialsByConditionWCO(j,2)+n1;
%                     tempData.correctByConditionWCO(j,2) = tempData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 3
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,3} = [tempData.trialNumsByCondition{j,3} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,3) = tempData.numTrialsByCondition(j,3)+n1;
%                 tempData.correctByCondition(j,3) = tempData.correctByCondition(j,3)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,3} = [tempData.trialNumsByConditionWCO{j,3} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,3) = tempData.numTrialsByConditionWCO(j,3)+n1;
%                     tempData.correctByConditionWCO(j,3) = tempData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 4
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,4} = [tempData.trialNumsByCondition{j,4} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,4) = tempData.numTrialsByCondition(j,4)+n1;
%                 tempData.correctByCondition(j,4) = tempData.correctByCondition(j,4)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,4} = [tempData.trialNumsByConditionWCO{j,4} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,4) = tempData.numTrialsByConditionWCO(j,4)+n1;
%                     tempData.correctByConditionWCO(j,4) = tempData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif tempData.conditionNum(i) == 5
%             for j = 1:length(tempData.tempFreqs)
%                 whichCurrContrast = tfThatDate==tempData.tempFreqs(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 tempData.trialNumsByCondition{j,5} = [tempData.trialNumsByCondition{j,5} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                 tempData.numTrialsByCondition(j,5) = tempData.numTrialsByCondition(j,5)+n1;
%                 tempData.correctByCondition(j,5) = tempData.correctByCondition(j,5)+x1;
%                 if tempData.dayMetCutOffCriterion(i)
%                     tempData.trialNumsByConditionWCO{j,5} = [tempData.trialNumsByConditionWCO{j,5} makerow(tempData.trialNumByDate{i}(whichCurrContrast))];
%                     tempData.numTrialsByConditionWCO(j,5) = tempData.numTrialsByConditionWCO(j,5)+n1;
%                     tempData.correctByConditionWCO(j,5) = tempData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(tempData.tempFreqs)
%     [phat,pci] = binofit(tempData.correctByCondition(j,:),tempData.numTrialsByCondition(j,:));
%     tempData.performanceByCondition(j,1,:) = phat;
%     tempData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([tempData.correctByConditionWCO(j,:)],[tempData.numTrialsByConditionWCO(j,:)]);
%     tempData.performanceByConditionWCO(j,1,:) = phat;
%     tempData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(tempData.trialNum)
%     figName = sprintf('%s::VARIABLE TF REVERSAL',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(tempData.dates-min(tempData.dates)+1,tempData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(tempData.dates)-min(tempData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(tempData.dates)-min(tempData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(tempData.dates)
%         if ~isnan(tempData.dayMetCutOffCriterion(i))
%             if tempData.dayMetCutOffCriterion(i)
%                 xloc = tempData.dates(i)-min(tempData.dates)+1;
%                 plot(xloc,tempData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],tempData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = tempData.dates(i)-min(tempData.dates)+1;
%                 plot(xloc,tempData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],tempData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = tempData.dates(i)-min(tempData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(tempData.performanceByConditionWCO,3)
%         for j = 1:size(tempData.performanceByConditionWCO,1)
%             if ~isnan(tempData.performanceByConditionWCO(j,1,i))
%                 xloc = log2(tempData.tempFreqs(j));
%                 plot(xloc,tempData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([xloc xloc],[tempData.performanceByConditionWCO(j,2,i) tempData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     xticks = log2([0.0625 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5 6 7 8 9 10 20]);
%     xticklabs = {'','0','','','','','','','','','1','','','','','','','','','10',''};
%     set(ax3,'ylim',[0.2 1.1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12,'xlim',log2([0.0625 32]),'xtick',xticks,'xticklabel',xticklabs);plot(get(gca,'xlim'),[0.5 0.5],'k-');plot(get(gca,'xlim'),[0.7 0.7],'k--');
%     xlabel('temp.freq.','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.tempRevData = tempData;
% 
% %% OR FREQ
% or1 = filterBehaviorData(data1,'tsName','orORSweep_nAFC');%1x1072 trials 
% orData.trialNum = [or1.compiledTrialRecords.trialNumber];
% orData.correct = [or1.compiledTrialRecords.correct];
% orData.correction = [or1.compiledTrialRecords.correctionTrial];
% orData.orientation = [or1.compiledDetails(2).records.orientations];
% orData.orientation = mod(round(rad2deg(abs(orData.orientation))),180);
% orData.time = [or1.compiledTrialRecords.date];
% orData.date = floor(orData.time);
% orData.dates = unique(orData.date);
% orData.orientations = unique(orData.orientation);
% 
% % performance on a day by day basis
% orData.trialNumByDate = cell(1,length(orData.dates));
% orData.numTrialsByDate = nan(1,length(orData.dates));
% orData.performanceByDate = nan(3,length(orData.dates));
% orData.colorByCondition = cell(1,length(orData.dates));
% orData.conditionNum = nan(1,length(orData.dates));
% orData.dayMetCutOffCriterion = nan(1,length(orData.dates));
% 
% %performance by condition
% orData.trialNumsByCondition = cell(length(orData.orientations),5);
% orData.numTrialsByCondition = zeros(length(orData.orientations),5);
% orData.correctByCondition = zeros(length(orData.orientations),5);
% orData.performanceByCondition = nan(length(orData.orientations),3,5);
% 
% %performance by condition with trial number cutoff
% orData.trialNumsByConditionWCO = cell(length(orData.orientations),5);
% orData.numTrialsByConditionWCO = zeros(length(orData.orientations),5);
% orData.correctByConditionWCO = zeros(length(orData.orientations),5);
% orData.performanceByConditionWCO = nan(length(orData.orientations),3,5);
% 
% for i = 1:length(orData.dates)
%     if ismember(orData.dates(i),filters.orFilter)
%         dateFilter = orData.date==orData.dates(i);
%         correctThatDate = orData.correct(dateFilter);
%         correctionThatDate = orData.correction(dateFilter);
%         orThatDate = orData.orientation(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         orThatDate = orThatDate(whichGood);
%  
%         orData.trialNumByDate{i} = orData.trialNum(dateFilter);
%         orData.trialNumByDate{i} = orData.trialNumByDate{i}(whichGood);
%         orData.numTrialsByDate(i) = length(orData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         orData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         orData.performanceByDate(1,i) = phat;
%         orData.performanceByDate(2,i) = pci(1);
%         orData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(orData.dates(i),datenum(daysPBS))
%             orData.colorByCondition{i} = 'b';
%             orData.conditionNum(i) = 1;
%         elseif ismember(orData.dates(i),datenum(daysCNO))
%             orData.colorByCondition{i} = 'r';
%             orData.conditionNum(i) = 2;
%         elseif ismember(orData.dates(i),datenum(daysIntact))
%             orData.colorByCondition{i} = 'b';
%             orData.conditionNum(i) = 3;
%         elseif ismember(orData.dates(i),datenum(daysLesion))
%             orData.colorByCondition{i} = 'r';
%             orData.conditionNum(i) = 4;
%         else
%             orData.colorByCondition{i} = 'k';
%             orData.conditionNum(i) = 5;
%         end
%                 
%         if orData.conditionNum(i) == 1
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,1} = [orData.trialNumsByCondition{j,1} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,1) = orData.numTrialsByCondition(j,1)+n1;
%                 orData.correctByCondition(j,1) = orData.correctByCondition(j,1)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,1} = [orData.trialNumsByConditionWCO{j,1} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,1) = orData.numTrialsByConditionWCO(j,1)+n1;
%                     orData.correctByConditionWCO(j,1) = orData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 2
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,2} = [orData.trialNumsByCondition{j,2} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,2) = orData.numTrialsByCondition(j,2)+n1;
%                 orData.correctByCondition(j,2) = orData.correctByCondition(j,2)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,2} = [orData.trialNumsByConditionWCO{j,2} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,2) = orData.numTrialsByConditionWCO(j,2)+n1;
%                     orData.correctByConditionWCO(j,2) = orData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 3
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,3} = [orData.trialNumsByCondition{j,3} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,3) = orData.numTrialsByCondition(j,3)+n1;
%                 orData.correctByCondition(j,3) = orData.correctByCondition(j,3)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,3} = [orData.trialNumsByConditionWCO{j,3} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,3) = orData.numTrialsByConditionWCO(j,3)+n1;
%                     orData.correctByConditionWCO(j,3) = orData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 4
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,4} = [orData.trialNumsByCondition{j,4} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,4) = orData.numTrialsByCondition(j,4)+n1;
%                 orData.correctByCondition(j,4) = orData.correctByCondition(j,4)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,4} = [orData.trialNumsByConditionWCO{j,4} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,4) = orData.numTrialsByConditionWCO(j,4)+n1;
%                     orData.correctByConditionWCO(j,4) = orData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 5
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,5} = [orData.trialNumsByCondition{j,5} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,5) = orData.numTrialsByCondition(j,5)+n1;
%                 orData.correctByCondition(j,5) = orData.correctByCondition(j,5)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,5} = [orData.trialNumsByConditionWCO{j,5} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,5) = orData.numTrialsByConditionWCO(j,5)+n1;
%                     orData.correctByConditionWCO(j,5) = orData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(orData.orientations)
%     [phat,pci] = binofit(orData.correctByCondition(j,:),orData.numTrialsByCondition(j,:));
%     orData.performanceByCondition(j,1,:) = phat;
%     orData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([orData.correctByConditionWCO(j,:)],[orData.numTrialsByConditionWCO(j,:)]);
%     orData.performanceByConditionWCO(j,1,:) = phat;
%     orData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(orData.trialNum)
%     figName = sprintf('%s::VARIABLE ORIENTATION',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(orData.dates-min(orData.dates)+1,orData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(orData.dates)-min(orData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(orData.dates)-min(orData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(orData.dates)
%         if ~isnan(orData.dayMetCutOffCriterion(i))
%             if orData.dayMetCutOffCriterion(i)
%                 xloc = orData.dates(i)-min(orData.dates)+1;
%                 plot(xloc,orData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],orData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = orData.dates(i)-min(orData.dates)+1;
%                 plot(xloc,orData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],orData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = orData.dates(i)-min(orData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(orData.performanceByConditionWCO,3)
%         for j = 1:size(orData.performanceByConditionWCO,1)
%             if ~isnan(orData.performanceByConditionWCO(j,1,i))
%                 xloc = orData.orientations(j);
%                 plot(xloc,orData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([xloc xloc],[orData.performanceByConditionWCO(j,2,i) orData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     xticks = [0 5 15 25 35 45];
%     xticklabs = {'0','','15','','35','45'};
%     set(ax3,'ylim',[0.2 1.1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12,'xlim',[-5 50],'xtick',xticks,'xticklabel',xticklabs);plot(get(gca,'xlim'),[0.5 0.5],'k-');plot(get(gca,'xlim'),[0.7 0.7],'k--');
%     xlabel('orientation','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.orData = orData;
% 
% %% OR REVERSAL
% or1 = [];
% orData = [];
% or1 = filterBehaviorData(data1,'tsName','orORSweep_nAFC');%1x1072 trials 
% orData.trialNum = [or1.compiledTrialRecords.trialNumber];
% orData.correct = [or1.compiledTrialRecords.correct];
% orData.correction = [or1.compiledTrialRecords.correctionTrial];
% orData.orientation = [or1.compiledDetails(2).records.orientations];
% orData.orientation = mod(round(rad2deg(abs(orData.orientation))),180);
% orData.time = [or1.compiledTrialRecords.date];
% orData.date = floor(orData.time);
% orData.dates = unique(orData.date);
% orData.orientations = unique(orData.orientation);
% 
% % performance on a day by day basis
% orData.trialNumByDate = cell(1,length(orData.dates));
% orData.numTrialsByDate = nan(1,length(orData.dates));
% orData.performanceByDate = nan(3,length(orData.dates));
% orData.colorByCondition = cell(1,length(orData.dates));
% orData.conditionNum = nan(1,length(orData.dates));
% orData.dayMetCutOffCriterion = nan(1,length(orData.dates));
% 
% %performance by condition
% orData.trialNumsByCondition = cell(length(orData.orientations),5);
% orData.numTrialsByCondition = zeros(length(orData.orientations),5);
% orData.correctByCondition = zeros(length(orData.orientations),5);
% orData.performanceByCondition = nan(length(orData.orientations),3,5);
% 
% %performance by condition with trial number cutoff
% orData.trialNumsByConditionWCO = cell(length(orData.orientations),5);
% orData.numTrialsByConditionWCO = zeros(length(orData.orientations),5);
% orData.correctByConditionWCO = zeros(length(orData.orientations),5);
% orData.performanceByConditionWCO = nan(length(orData.orientations),3,5);
% 
% for i = 1:length(orData.dates)
%     if ismember(orData.dates(i),filters.orRevFilter)
%         dateFilter = orData.date==orData.dates(i);
%         correctThatDate = orData.correct(dateFilter);
%         correctionThatDate = orData.correction(dateFilter);
%         orThatDate = orData.orientation(dateFilter);
%         % filter out the nans
%         whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
%         correctThatDate = correctThatDate(whichGood);
%         orThatDate = orThatDate(whichGood);
%  
%         orData.trialNumByDate{i} = orData.trialNum(dateFilter);
%         orData.trialNumByDate{i} = orData.trialNumByDate{i}(whichGood);
%         orData.numTrialsByDate(i) = length(orData.trialNumByDate{i});
% 
%         x = sum(correctThatDate);
%         n = length(correctThatDate);
%         orData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
%         [phat,pci] = binofit(x,n);
%         orData.performanceByDate(1,i) = phat;
%         orData.performanceByDate(2,i) = pci(1);
%         orData.performanceByDate(3,i) = pci(2);
%         
%         if ismember(orData.dates(i),datenum(daysPBS))
%             orData.colorByCondition{i} = 'b';
%             orData.conditionNum(i) = 1;
%         elseif ismember(orData.dates(i),datenum(daysCNO))
%             orData.colorByCondition{i} = 'r';
%             orData.conditionNum(i) = 2;
%         elseif ismember(orData.dates(i),datenum(daysIntact))
%             orData.colorByCondition{i} = 'b';
%             orData.conditionNum(i) = 3;
%         elseif ismember(orData.dates(i),datenum(daysLesion))
%             orData.colorByCondition{i} = 'r';
%             orData.conditionNum(i) = 4;
%         else
%             orData.colorByCondition{i} = 'k';
%             orData.conditionNum(i) = 5;
%         end
%                 
%         if orData.conditionNum(i) == 1
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,1} = [orData.trialNumsByCondition{j,1} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,1) = orData.numTrialsByCondition(j,1)+n1;
%                 orData.correctByCondition(j,1) = orData.correctByCondition(j,1)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,1} = [orData.trialNumsByConditionWCO{j,1} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,1) = orData.numTrialsByConditionWCO(j,1)+n1;
%                     orData.correctByConditionWCO(j,1) = orData.correctByConditionWCO(j,1)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 2
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,2} = [orData.trialNumsByCondition{j,2} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,2) = orData.numTrialsByCondition(j,2)+n1;
%                 orData.correctByCondition(j,2) = orData.correctByCondition(j,2)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,2} = [orData.trialNumsByConditionWCO{j,2} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,2) = orData.numTrialsByConditionWCO(j,2)+n1;
%                     orData.correctByConditionWCO(j,2) = orData.correctByConditionWCO(j,2)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 3
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,3} = [orData.trialNumsByCondition{j,3} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,3) = orData.numTrialsByCondition(j,3)+n1;
%                 orData.correctByCondition(j,3) = orData.correctByCondition(j,3)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,3} = [orData.trialNumsByConditionWCO{j,3} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,3) = orData.numTrialsByConditionWCO(j,3)+n1;
%                     orData.correctByConditionWCO(j,3) = orData.correctByConditionWCO(j,3)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 4
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,4} = [orData.trialNumsByCondition{j,4} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,4) = orData.numTrialsByCondition(j,4)+n1;
%                 orData.correctByCondition(j,4) = orData.correctByCondition(j,4)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,4} = [orData.trialNumsByConditionWCO{j,4} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,4) = orData.numTrialsByConditionWCO(j,4)+n1;
%                     orData.correctByConditionWCO(j,4) = orData.correctByConditionWCO(j,4)+x1;
%                 end
%             end
%         elseif orData.conditionNum(i) == 5
%             for j = 1:length(orData.orientations)
%                 whichCurrContrast = orThatDate==orData.orientations(j);
%                 currContrastCorrect = correctThatDate(whichCurrContrast);
%                 x1 = sum(currContrastCorrect);
%                 n1 = length(currContrastCorrect);
%                 orData.trialNumsByCondition{j,5} = [orData.trialNumsByCondition{j,5} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                 orData.numTrialsByCondition(j,5) = orData.numTrialsByCondition(j,5)+n1;
%                 orData.correctByCondition(j,5) = orData.correctByCondition(j,5)+x1;
%                 if orData.dayMetCutOffCriterion(i)
%                     orData.trialNumsByConditionWCO{j,5} = [orData.trialNumsByConditionWCO{j,5} makerow(orData.trialNumByDate{i}(whichCurrContrast))];
%                     orData.numTrialsByConditionWCO(j,5) = orData.numTrialsByConditionWCO(j,5)+n1;
%                     orData.correctByConditionWCO(j,5) = orData.correctByConditionWCO(j,5)+x1;
%                 end
%             end
%         else
%             error('unknown condition');
%         end
%         
%     end
% end
% 
% 
% for j = 1:length(orData.orientations)
%     [phat,pci] = binofit(orData.correctByCondition(j,:),orData.numTrialsByCondition(j,:));
%     orData.performanceByCondition(j,1,:) = phat;
%     orData.performanceByCondition(j,2:3,:) = pci';
%     
%     [phat,pci] = binofit([orData.correctByConditionWCO(j,:)],[orData.numTrialsByConditionWCO(j,:)]);
%     orData.performanceByConditionWCO(j,1,:) = phat;
%     orData.performanceByConditionWCO(j,2:3,:) = pci';
% end
% 
% if plotOn && ~isempty(orData.trialNum)
%     figName = sprintf('%s::VARIABLE ORIENTATION REVERSAL',mouseID);
%     f = figure('NAME',figName);
%     ax1 = subplot(3,2,1); hold on;
%     bar(orData.dates-min(orData.dates)+1,orData.numTrialsByDate);
%     xlabel('num days','FontName','Times New Roman','FontSize',12);
%     ylabel('num trials','FontName','Times New Roman','FontSize',12);
%     
%     ax2 = subplot(3,2,2); hold on;
%     plot([0 max(orData.dates)-min(orData.dates)+1],[0.5 0.5],'k');
%     plot([0 max(orData.dates)-min(orData.dates)+1],[0.7 0.7],'k--');
%     for i = 1:length(orData.dates)
%         if ~isnan(orData.dayMetCutOffCriterion(i))
%             if orData.dayMetCutOffCriterion(i)
%                 xloc = orData.dates(i)-min(orData.dates)+1;
%                 plot(xloc,orData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
%                 plot([xloc xloc],orData.performanceByDate(2:3,i),'color','k','LineWidth',2);
%             else
%                 xloc = orData.dates(i)-min(orData.dates)+1;
%                 plot(xloc,orData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
%                 plot([xloc xloc],orData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
%             end
%         else
%             xloc = orData.dates(i)-min(orData.dates)+1;
%             plot(xloc,0.5,'Marker','x','color','k');
%         end
%     end
%     set(ax2,'ylim',[0.2 1]); 
%     xlabel('day num','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);
%     
%     
%     ax3 = subplot(3,2,3:6); hold on;
%     conditionColor = {'b','r','b','r','k'};
%     for i = 1:size(orData.performanceByConditionWCO,3)
%         for j = 1:size(orData.performanceByConditionWCO,1)
%             if ~isnan(orData.performanceByConditionWCO(j,1,i))
%                 xloc = orData.orientations(j);
%                 plot(xloc,orData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
%                 plot([xloc xloc],[orData.performanceByConditionWCO(j,2,i) orData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
%             end
%         end
%     end
%     xticks = [0 5 15 25 35 45];
%     xticklabs = {'0','','15','','35','45'};
%     set(ax3,'ylim',[0.2 1.1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12,'xlim',[-5 50],'xtick',xticks,'xticklabel',xticklabs);plot(get(gca,'xlim'),[0.5 0.5],'k-');plot(get(gca,'xlim'),[0.7 0.7],'k--');
%     xlabel('orientation','FontName','Times New Roman','FontSize',12);
%     ylabel('performance','FontName','Times New Roman','FontSize',12);       
% end
% out.orRevData = orData;