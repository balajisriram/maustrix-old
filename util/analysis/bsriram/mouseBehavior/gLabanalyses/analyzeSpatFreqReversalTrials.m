function spatRevFreqData = analyzeSpatFreqReversalTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion)

if islogical(plotDetails)
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'makeFigure';
end

spatRev = filterBehaviorData(data,'tsName','orSFSweep_Reversal_nAFC');
spatRevFreqData.trialNum = [spatRev.compiledTrialRecords.trialNumber];
spatRevFreqData.correct = [spatRev.compiledTrialRecords.correct];
spatRevFreqData.correction = [spatRev.compiledTrialRecords.correctionTrial];
whichDetailFileNum = find(strcmp({spatRev.compiledDetails.className},'afcGratings'));
spatRevFreqData.contrast = [spatRev.compiledDetails(whichDetailFileNum).records.contrasts];
spatRevFreqData.time = [spatRev.compiledTrialRecords.date];
spatRevFreqData.date = floor(spatRevFreqData.time);
spatRevFreqData.dates = unique(spatRevFreqData.date);
spatRevFreqData.contrasts = unique(spatRevFreqData.contrast);

% performance on a day by day basis
spatRevFreqData.trialNumByDate = cell(1,length(spatRevFreqData.dates));
spatRevFreqData.numTrialsByDate = nan(1,length(spatRevFreqData.dates));
spatRevFreqData.performanceByDate = nan(3,length(spatRevFreqData.dates));
spatRevFreqData.colorByCondition = cell(1,length(spatRevFreqData.dates));
spatRevFreqData.conditionNum = nan(1,length(spatRevFreqData.dates));
spatRevFreqData.dayMetCutOffCriterion = nan(1,length(spatRevFreqData.dates));

%performance by condition
spatRevFreqData.trialNumsByCondition = cell(length(spatRevFreqData.contrasts),5);
spatRevFreqData.numTrialsByCondition = zeros(length(spatRevFreqData.contrasts),5);
spatRevFreqData.correctByCondition = zeros(length(spatRevFreqData.contrasts),5);
spatRevFreqData.performanceByCondition = nan(length(spatRevFreqData.contrasts),3,5);

%performance by condition with trial number cutoff
spatRevFreqData.trialNumsByConditionWCO = cell(length(spatRevFreqData.contrasts),5);
spatRevFreqData.numTrialsByConditionWCO = zeros(length(spatRevFreqData.contrasts),5);
spatRevFreqData.correctByConditionWCO = zeros(length(spatRevFreqData.contrasts),5);
spatRevFreqData.performanceByConditionWCO = nan(length(spatRevFreqData.contrasts),3,5);

for i = 1:length(spatRevFreqData.dates)
    warning('need to select mainly for spat. freq.');
    keyboard
    if ismember(spatRevFreqData.dates(i),filters.ctrFilter)
        dateFilter = spatRevFreqData.date==spatRevFreqData.dates(i);
        correctThatDate = spatRevFreqData.correct(dateFilter);
        correctionThatDate = spatRevFreqData.correction(dateFilter);
        contrastThatDate = spatRevFreqData.contrast(dateFilter);
        % filter out the nans
        whichGood = ~isnan(correctThatDate) & ~correctionThatDate;
        correctThatDate = correctThatDate(whichGood);
        contrastThatDate = contrastThatDate(whichGood);
 
        spatRevFreqData.trialNumByDate{i} = spatRevFreqData.trialNum(dateFilter);
        spatRevFreqData.trialNumByDate{i} = spatRevFreqData.trialNumByDate{i}(whichGood);
        spatRevFreqData.numTrialsByDate(i) = length(spatRevFreqData.trialNumByDate{i});

        x = sum(correctThatDate);
        n = length(correctThatDate);
        spatRevFreqData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
        [phat,pci] = binofit(x,n);
        spatRevFreqData.performanceByDate(1,i) = phat;
        spatRevFreqData.performanceByDate(2,i) = pci(1);
        spatRevFreqData.performanceByDate(3,i) = pci(2);
        
        if ismember(spatRevFreqData.dates(i),daysPBS)
            spatRevFreqData.colorByCondition{i} = 'b';
            spatRevFreqData.conditionNum(i) = 1;
        elseif ismember(spatRevFreqData.dates(i),daysCNO)
            spatRevFreqData.colorByCondition{i} = 'r';
            spatRevFreqData.conditionNum(i) = 2;
        elseif ismember(spatRevFreqData.dates(i),daysIntact)
            spatRevFreqData.colorByCondition{i} = 'b';
            spatRevFreqData.conditionNum(i) = 3;
        elseif ismember(spatRevFreqData.dates(i),daysLesion)
            spatRevFreqData.colorByCondition{i} = 'r';
            spatRevFreqData.conditionNum(i) = 4;
        else
            spatRevFreqData.colorByCondition{i} = 'k';
            spatRevFreqData.conditionNum(i) = 5;
        end
                
        if spatRevFreqData.conditionNum(i) == 1
            for j = 1:length(spatRevFreqData.contrasts)
                whichCurrContrast = contrastThatDate==spatRevFreqData.contrasts(j);
                currContrastCorrect = correctThatDate(whichCurrContrast);
                x1 = sum(currContrastCorrect);
                n1 = length(currContrastCorrect);
                spatRevFreqData.trialNumsByCondition{j,1} = [spatRevFreqData.trialNumsByCondition{j,1} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                spatRevFreqData.numTrialsByCondition(j,1) = spatRevFreqData.numTrialsByCondition(j,1)+n1;
                spatRevFreqData.correctByCondition(j,1) = spatRevFreqData.correctByCondition(j,1)+x1;
                if spatRevFreqData.dayMetCutOffCriterion(i)
                    spatRevFreqData.trialNumsByConditionWCO{j,1} = [spatRevFreqData.trialNumsByConditionWCO{j,1} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                    spatRevFreqData.numTrialsByConditionWCO(j,1) = spatRevFreqData.numTrialsByConditionWCO(j,1)+n1;
                    spatRevFreqData.correctByConditionWCO(j,1) = spatRevFreqData.correctByConditionWCO(j,1)+x1;
                end
            end
        elseif spatRevFreqData.conditionNum(i) == 2
            for j = 1:length(spatRevFreqData.contrasts)
                whichCurrContrast = contrastThatDate==spatRevFreqData.contrasts(j);
                currContrastCorrect = correctThatDate(whichCurrContrast);
                x1 = sum(currContrastCorrect);
                n1 = length(currContrastCorrect);
                spatRevFreqData.trialNumsByCondition{j,2} = [spatRevFreqData.trialNumsByCondition{j,2} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                spatRevFreqData.numTrialsByCondition(j,2) = spatRevFreqData.numTrialsByCondition(j,2)+n1;
                spatRevFreqData.correctByCondition(j,2) = spatRevFreqData.correctByCondition(j,2)+x1;
                if spatRevFreqData.dayMetCutOffCriterion(i)
                    spatRevFreqData.trialNumsByConditionWCO{j,2} = [spatRevFreqData.trialNumsByConditionWCO{j,2} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                    spatRevFreqData.numTrialsByConditionWCO(j,2) = spatRevFreqData.numTrialsByConditionWCO(j,2)+n1;
                    spatRevFreqData.correctByConditionWCO(j,2) = spatRevFreqData.correctByConditionWCO(j,2)+x1;
                end
            end
        elseif spatRevFreqData.conditionNum(i) == 3
            for j = 1:length(spatRevFreqData.contrasts)
                whichCurrContrast = contrastThatDate==spatRevFreqData.contrasts(j);
                currContrastCorrect = correctThatDate(whichCurrContrast);
                x1 = sum(currContrastCorrect);
                n1 = length(currContrastCorrect);
                spatRevFreqData.trialNumsByCondition{j,3} = [spatRevFreqData.trialNumsByCondition{j,3} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                spatRevFreqData.numTrialsByCondition(j,3) = spatRevFreqData.numTrialsByCondition(j,3)+n1;
                spatRevFreqData.correctByCondition(j,3) = spatRevFreqData.correctByCondition(j,3)+x1;
                if spatRevFreqData.dayMetCutOffCriterion(i)
                    spatRevFreqData.trialNumsByConditionWCO{j,3} = [spatRevFreqData.trialNumsByConditionWCO{j,3} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                    spatRevFreqData.numTrialsByConditionWCO(j,3) = spatRevFreqData.numTrialsByConditionWCO(j,3)+n1;
                    spatRevFreqData.correctByConditionWCO(j,3) = spatRevFreqData.correctByConditionWCO(j,3)+x1;
                end
            end
        elseif spatRevFreqData.conditionNum(i) == 4
            for j = 1:length(spatRevFreqData.contrasts)
                whichCurrContrast = contrastThatDate==spatRevFreqData.contrasts(j);
                currContrastCorrect = correctThatDate(whichCurrContrast);
                x1 = sum(currContrastCorrect);
                n1 = length(currContrastCorrect);
                spatRevFreqData.trialNumsByCondition{j,4} = [spatRevFreqData.trialNumsByCondition{j,4} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                spatRevFreqData.numTrialsByCondition(j,4) = spatRevFreqData.numTrialsByCondition(j,4)+n1;
                spatRevFreqData.correctByCondition(j,4) = spatRevFreqData.correctByCondition(j,4)+x1;
                if spatRevFreqData.dayMetCutOffCriterion(i)
                    spatRevFreqData.trialNumsByConditionWCO{j,4} = [spatRevFreqData.trialNumsByConditionWCO{j,4} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                    spatRevFreqData.numTrialsByConditionWCO(j,4) = spatRevFreqData.numTrialsByConditionWCO(j,4)+n1;
                    spatRevFreqData.correctByConditionWCO(j,4) = spatRevFreqData.correctByConditionWCO(j,4)+x1;
                end
            end
        elseif spatRevFreqData.conditionNum(i) == 5
            for j = 1:length(spatRevFreqData.contrasts)
                whichCurrContrast = contrastThatDate==spatRevFreqData.contrasts(j);
                currContrastCorrect = correctThatDate(whichCurrContrast);
                x1 = sum(currContrastCorrect);
                n1 = length(currContrastCorrect);
                spatRevFreqData.trialNumsByCondition{j,5} = [spatRevFreqData.trialNumsByCondition{j,5} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                spatRevFreqData.numTrialsByCondition(j,5) = spatRevFreqData.numTrialsByCondition(j,5)+n1;
                spatRevFreqData.correctByCondition(j,5) = spatRevFreqData.correctByCondition(j,5)+x1;
                if spatRevFreqData.dayMetCutOffCriterion(i)
                    spatRevFreqData.trialNumsByConditionWCO{j,5} = [spatRevFreqData.trialNumsByConditionWCO{j,5} makerow(spatRevFreqData.trialNumByDate{i}(whichCurrContrast))];
                    spatRevFreqData.numTrialsByConditionWCO(j,5) = spatRevFreqData.numTrialsByConditionWCO(j,5)+n1;
                    spatRevFreqData.correctByConditionWCO(j,5) = spatRevFreqData.correctByConditionWCO(j,5)+x1;
                end
            end
        else
            error('unknown condition');
        end
        
    end
end


for j = 1:length(spatRevFreqData.contrasts)
    [phat,pci] = binofit(spatRevFreqData.correctByCondition(j,:),spatRevFreqData.numTrialsByCondition(j,:));
    spatRevFreqData.performanceByCondition(j,1,:) = phat;
    spatRevFreqData.performanceByCondition(j,2:3,:) = pci';
    
    [phat,pci] = binofit([spatRevFreqData.correctByConditionWCO(j,:)],[spatRevFreqData.numTrialsByConditionWCO(j,:)]);
    spatRevFreqData.performanceByConditionWCO(j,1,:) = phat;
    spatRevFreqData.performanceByConditionWCO(j,2:3,:) = pci';
end



if plotDetails.plotOn
    switch plotDetails.plotWhere
        case 'givenAxes'
            axes(plotDetails.axHan); hold on;
            title(sprintf('%s::CONTRAST',mouseID));
            switch plotDetails.requestedPlot
                case 'trialsByDay'
                    bar(spatRevFreqData.dates-min(spatRevFreqData.dates)+1,spatRevFreqData.numTrialsByDate);
                    xlabel('num days','FontName','Times New Roman','FontSize',12);
                    ylabel('num trials','FontName','Times New Roman','FontSize',12);
                    
                case 'performanceByCondition'
                    conditionColor = {'b','r','b','r','k'};
                    for i = 1:size(spatRevFreqData.performanceByConditionWCO,3)
                        for j = 1:size(spatRevFreqData.performanceByConditionWCO,1)
                            if ~isnan(spatRevFreqData.performanceByConditionWCO(j,1,i))
                                plot(spatRevFreqData.contrasts(j),spatRevFreqData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
                                plot([spatRevFreqData.contrasts(j) spatRevFreqData.contrasts(j)],[spatRevFreqData.performanceByConditionWCO(j,2,i) spatRevFreqData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
                            end
                        end
                    end
                    set(gca,'ylim',[0.2 1.1],'xlim',[0 1],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
                    xlabel('contrast','FontName','Times New Roman','FontSize',12);
                    ylabel('performance','FontName','Times New Roman','FontSize',12);
                    
                case 'performanceByDay'
                    plot([0 max(spatRevFreqData.dates)-min(spatRevFreqData.dates)+1],[0.5 0.5],'k');
                    plot([0 max(spatRevFreqData.dates)-min(spatRevFreqData.dates)+1],[0.7 0.7],'k--');
                    for i = 1:length(spatRevFreqData.dates)
                        if ~isnan(spatRevFreqData.dayMetCutOffCriterion(i))
                            if spatRevFreqData.dayMetCutOffCriterion(i)
                                xloc = spatRevFreqData.dates(i)-min(spatRevFreqData.dates)+1;
                                plot(xloc,spatRevFreqData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
                                plot([xloc xloc],spatRevFreqData.performanceByDate(2:3,i),'color','k','LineWidth',2);
                            else
                                xloc = spatRevFreqData.dates(i)-min(spatRevFreqData.dates)+1;
                                plot(xloc,spatRevFreqData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
                                plot([xloc xloc],spatRevFreqData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
                            end
                        else
                            xloc = spatRevFreqData.dates(i)-min(spatRevFreqData.dates)+1;
                            plot(xloc,0.5,'Marker','x','color','k');
                        end
                    end
                    set(gca,'ylim',[0.2 1]);
                    xlabel('day num','FontName','Times New Roman','FontSize',12);
                    ylabel('performance','FontName','Times New Roman','FontSize',12);
                otherwise
                    error('wtf!');
            end
            
            
        case {'givenFigure','makeFigure'}
            figName = sprintf('%s::OPTIMAL',mouseID);
            if strcmp(plotDetails.plotWhere,'makeFigure')
                f = figure('name',figName);
            else
                figure(plotDetails.figHan)
            end
            
            % trials by day
            ax1 = subplot(3,2,1); hold on;
            bar(spatRevFreqData.dates-min(spatRevFreqData.dates)+1,spatRevFreqData.numTrialsByDate);
            xlabel('num days','FontName','Times New Roman','FontSize',12);
            ylabel('num trials','FontName','Times New Roman','FontSize',12);
            
            % performance by day
            ax2 = subplot(3,2,2); hold on;
            plot([0 max(spatRevFreqData.dates)-min(spatRevFreqData.dates)+1],[0.5 0.5],'k');
            plot([0 max(spatRevFreqData.dates)-min(spatRevFreqData.dates)+1],[0.7 0.7],'k--');
            for i = 1:length(spatRevFreqData.dates)
                if ~isnan(spatRevFreqData.dayMetCutOffCriterion(i))
                    if spatRevFreqData.dayMetCutOffCriterion(i)
                        xloc = spatRevFreqData.dates(i)-min(spatRevFreqData.dates)+1;
                        plot(xloc,spatRevFreqData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
                        plot([xloc xloc],spatRevFreqData.performanceByDate(2:3,i),'color','k','LineWidth',2);
                    else
                        xloc = spatRevFreqData.dates(i)-min(spatRevFreqData.dates)+1;
                        plot(xloc,spatRevFreqData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
                        plot([xloc xloc],spatRevFreqData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
                    end
                else
                    xloc = spatRevFreqData.dates(i)-min(spatRevFreqData.dates)+1;
                    plot(xloc,0.5,'Marker','x','color','k');
                end
            end
            set(ax2,'ylim',[0.2 1]);
            xlabel('day num','FontName','Times New Roman','FontSize',12);
            ylabel('performance','FontName','Times New Roman','FontSize',12);
            
            % performance by condition
            ax3 = subplot(3,2,3:6); hold on;
            conditionColor = {'b','r','b','r','k'};
            for i = 1:size(spatRevFreqData.performanceByConditionWCO,3)
                for j = 1:size(spatRevFreqData.performanceByConditionWCO,1)
                    if ~isnan(spatRevFreqData.performanceByConditionWCO(j,1,i))
                        plot(spatRevFreqData.contrasts(j),spatRevFreqData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
                        plot([spatRevFreqData.contrasts(j) spatRevFreqData.contrasts(j)],[spatRevFreqData.performanceByConditionWCO(j,2,i) spatRevFreqData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
                    end
                end
            end
            set(ax3,'ylim',[0.2 1.1],'xlim',[0 1],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
            xlabel('contrast','FontName','Times New Roman','FontSize',12);
            ylabel('performance','FontName','Times New Roman','FontSize',12);
    end
end