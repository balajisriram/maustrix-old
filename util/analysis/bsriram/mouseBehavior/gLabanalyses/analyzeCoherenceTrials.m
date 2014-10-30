function cohData = analyzeCoherenceTrials(mouseID,data,filters,plotDetails,trialNumCutoff,daysPBS,daysCNO,daysIntact,daysLesion)

if islogical(plotDetails)
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'makeFigure';
end
if isfield(filters,'tsName') && ~isempty(filters.tsName)
    tsName = filters.tsName;
else
    tsName = 'orDURSweep';
end

coh = filterBehaviorData(data,'tsName',tsName); 
cohData.trialNum = [coh.compiledTrialRecords.trialNumber];
cohData.correct = [coh.compiledTrialRecords.correct];
cohData.correction = [coh.compiledTrialRecords.correctionTrial];
cohData.responseTime = [coh.compiledTrialRecords.responseTime];
whichDetailFileNum = find(strcmp({coh.compiledDetails.className},'coherentDots'));
cohData.coherence = [coh.compiledDetails(whichDetailFileNum).records.selectedCoherence];
cohData.time = [coh.compiledTrialRecords.date];
cohData.date = floor(cohData.time);
cohData.dates = unique(cohData.date);
cohData.coherences = unique(cohData.coherence);

% performance on a day by day basis
cohData.trialNumByDate = cell(1,length(cohData.dates));
cohData.numTrialsByDate = nan(1,length(cohData.dates));
cohData.performanceByDate = nan(3,length(cohData.dates));
cohData.colorByCondition = cell(1,length(cohData.dates));
cohData.conditionNum = nan(1,length(cohData.dates));
cohData.dayMetCutOffCriterion = nan(1,length(cohData.dates));

%performance by condition
cohData.trialNumsByCondition = cell(length(cohData.coherences),5);
cohData.numTrialsByCondition = zeros(length(cohData.coherences),5);
cohData.correctByCondition = zeros(length(cohData.coherences),5);
cohData.performanceByCondition = nan(length(cohData.coherences),3,5);
cohData.responseTimesByCondition = cell(length(cohData.coherences),5);
cohData.responseTimesForCorrectByCondition = cell(length(cohData.coherences),5);

%performance by condition with trial number cutoff
cohData.trialNumsByConditionWCO = cell(length(cohData.coherences),5);
cohData.numTrialsByConditionWCO = zeros(length(cohData.coherences),5);
cohData.correctByConditionWCO = zeros(length(cohData.coherences),5);
cohData.performanceByConditionWCO = nan(length(cohData.coherences),3,5);
cohData.responseTimesByConditionWCO = cell(length(cohData.coherences),5);
cohData.responseTimesForCorrectByConditionWCO = cell(length(cohData.coherences),5);

for i = 1:length(cohData.dates)
    if ismember(cohData.dates(i),filters.cohFilter)
        dateFilter = cohData.date==cohData.dates(i);
        correctThatDate = cohData.correct(dateFilter);
        correctionThatDate = cohData.correction(dateFilter);
        coherenceThatDate = cohData.coherence(dateFilter);
        responseTimeThatDate = cohData.responseTime(dateFilter);

        % filter out the nans
        whichGood = ~isnan(correctThatDate) & ~correctionThatDate & responseTimeThatDate<5;
        correctThatDate = correctThatDate(whichGood);
        coherenceThatDate = coherenceThatDate(whichGood);
        responseTimeThatDate = responseTimeThatDate(whichGood);
        
        cohData.trialNumByDate{i} = cohData.trialNum(dateFilter);
        cohData.trialNumByDate{i} = cohData.trialNumByDate{i}(whichGood);
        cohData.numTrialsByDate(i) = length(cohData.trialNumByDate{i});

        x = sum(correctThatDate);
        n = length(correctThatDate);
        cohData.dayMetCutOffCriterion(i) = n>=trialNumCutoff;
        [phat,pci] = binofit(x,n);
        cohData.performanceByDate(1,i) = phat;
        cohData.performanceByDate(2,i) = pci(1);
        cohData.performanceByDate(3,i) = pci(2);
        
        if ismember(cohData.dates(i),daysPBS)
            cohData.colorByCondition{i} = 'b';
            cohData.conditionNum(i) = 1;
        elseif ismember(cohData.dates(i),daysCNO)
            cohData.colorByCondition{i} = 'r';
            cohData.conditionNum(i) = 2;
        elseif ismember(cohData.dates(i),daysIntact)
            cohData.colorByCondition{i} = 'b';
            cohData.conditionNum(i) = 3;
        elseif ismember(cohData.dates(i),daysLesion)
            cohData.colorByCondition{i} = 'r';
            cohData.conditionNum(i) = 4;
        else
            cohData.colorByCondition{i} = 'k';
            cohData.conditionNum(i) = 5;
        end
        
        for j = 1:length(cohData.coherences)
            whichCurrDurationAndCoherence = coherenceThatDate==cohData.coherences(j);
            currDurationAndCoherenceCorrect = correctThatDate(whichCurrDurationAndCoherence);
            currResponseTimes = responseTimeThatDate(whichCurrDurationAndCoherence);
            currCorrectResponseTimes = currResponseTimes(logical(currDurationAndCoherenceCorrect));
            x1 = sum(currDurationAndCoherenceCorrect);
            n1 = length(currDurationAndCoherenceCorrect);
            cohData.trialNumsByCondition{j,cohData.conditionNum(i)} = [cohData.trialNumsByCondition{j,cohData.conditionNum(i)} makerow(cohData.trialNumByDate{i}(whichCurrDurationAndCoherence))];
            cohData.numTrialsByCondition(j,cohData.conditionNum(i)) = cohData.numTrialsByCondition(j,cohData.conditionNum(i))+n1;
            cohData.correctByCondition(j,cohData.conditionNum(i)) = cohData.correctByCondition(j,cohData.conditionNum(i))+x1;
            cohData.responseTimesByCondition{j,cohData.conditionNum(i)} = [cohData.responseTimesByCondition{j,cohData.conditionNum(i)} makerow(currResponseTimes)];
            cohData.responseTimesForCorrectByCondition{j,cohData.conditionNum(i)} = [cohData.responseTimesForCorrectByCondition{j,cohData.conditionNum(i)} makerow(currCorrectResponseTimes)];
            
            if cohData.dayMetCutOffCriterion(i)
                cohData.trialNumsByConditionWCO{j,cohData.conditionNum(i)} = [cohData.trialNumsByConditionWCO{j,cohData.conditionNum(i)} makerow(cohData.trialNumByDate{i}(whichCurrDurationAndCoherence))];
                cohData.numTrialsByConditionWCO(j,cohData.conditionNum(i)) = cohData.numTrialsByConditionWCO(j,cohData.conditionNum(i))+n1;
                cohData.correctByConditionWCO(j,cohData.conditionNum(i)) = cohData.correctByConditionWCO(j,cohData.conditionNum(i))+x1;
                cohData.responseTimesByConditionWCO{j,cohData.conditionNum(i)} = [cohData.responseTimesByConditionWCO{j,cohData.conditionNum(i)} makerow(currResponseTimes)];
                cohData.responseTimesForCorrectByConditionWCO{j,cohData.conditionNum(i)} = [cohData.responseTimesForCorrectByConditionWCO{j,cohData.conditionNum(i)} makerow(currCorrectResponseTimes)];
            end
        end
        
    end
end

for j = 1:length(cohData.coherences)
    [phat,pci] = binofit(cohData.correctByCondition(j,:),cohData.numTrialsByCondition(j,:));
    cohData.performanceByCondition(j,1,:) = phat;
    cohData.performanceByCondition(j,2:3,:) = pci';
    
    [phat,pci] = binofit([cohData.correctByConditionWCO(j,:)],[cohData.numTrialsByConditionWCO(j,:)]);
    cohData.performanceByConditionWCO(j,1,:) = phat;
    cohData.performanceByConditionWCO(j,2:3,:) = pci';
end



if plotDetails.plotOn
    switch plotDetails.plotWhere
        case 'givenAxes'
            axes(plotDetails.axHan); hold on;
            title(sprintf('%s::COHERENCE',mouseID));
            switch plotDetails.requestedPlot
                case 'trialsByDay'
                    bar(cohData.dates-min(cohData.dates)+1,cohData.numTrialsByDate);
                    xlabel('num days','FontName','Times New Roman','FontSize',12);
                    ylabel('num trials','FontName','Times New Roman','FontSize',12);
                    
                case 'performanceByCondition'
                    conditionColor = {'b','r','b','r','g'};
                    % now performance is a 4D vector (durationsXcontrastsX[phat pcilow pcihi]Xcondition)
                    % separate by condition
                    for i = 1:size(cohData.performanceByConditionWCO,3)
                        % now separate by contrast
                        if isfield(plotDetails,'plotMeansOnly') && plotDetails.plotMeansOnly
                            means = cohData.performanceByConditionWCO(:,1,i);
                            which = ~isnan(cohData.performanceByConditionWCO(:,1,i));
                            
                            if ~isempty(cohData.coherences(which))
                                h = plot(log10(cohData.coherences(which)),means(which),'color',conditionColor{i});
                            end
                        else
                            for j = 1:size(cohData.performanceByConditionWCO,1)
                                if ~isnan(cohData.performanceByConditionWCO(j,1,i))
                                    h1 = plot(log10(cohData.coherences(j)),cohData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
                                    h2 = plot([log10(cohData.coherences(j)) log10(cohData.coherences(j))],[cohData.performanceByConditionWCO(j,2,i) cohData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
                                end
                            end
                        end
                    end
                    xlabels = cell(1,length(cohData.coherences));
                    for i = 1:length(cohData.coherences)
                        xlabels{i} = sprintf('%2.2f',cohData.coherences(i));
                    end
                    set(gca,'ylim',[0.2 1.1],'xlim',[log10(min(cohData.coherences))-0.05 log10(max(cohData.coherences))+0.05],'xtick',log10(cohData.coherences),'xticklabel',xlabels,'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12);
                    plot([log10(min(cohData.coherences))-0.05 log10(max(cohData.coherences))+0.05],[0.5 0.5],'k-');
                    plot([log10(min(cohData.coherences))-0.05 log10(max(cohData.coherences))+0.05],[0.7 0.7],'k--');
                    xlabel('coherences','FontName','Times New Roman','FontSize',12);
                    ylabel('performance','FontName','Times New Roman','FontSize',12);
                    
                case 'performanceByDay'
                    plot([0 max(cohData.dates)-min(cohData.dates)+1],[0.5 0.5],'k');
                    plot([0 max(cohData.dates)-min(cohData.dates)+1],[0.7 0.7],'k--');
                    for i = 1:length(cohData.dates)
                        if ~isnan(cohData.dayMetCutOffCriterion(i))
                            if cohData.dayMetCutOffCriterion(i)
                                xloc = cohData.dates(i)-min(cohData.dates)+1;
                                plot(xloc,cohData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
                                plot([xloc xloc],cohData.performanceByDate(2:3,i),'color','k','LineWidth',2);
                            else
                                xloc = cohData.dates(i)-min(cohData.dates)+1;
                                plot(xloc,cohData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
                                plot([xloc xloc],cohData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
                            end
                        else
                            xloc = cohData.dates(i)-min(cohData.dates)+1;
                            plot(xloc,0.5,'Marker','x','color','k');
                        end
                    end
                    set(gca,'ylim',[0.2 1]);
                    xlabel('day num','FontName','Times New Roman','FontSize',12);
                    ylabel('performance','FontName','Times New Roman','FontSize',12);
                case 'responseTime'
                    keyboard
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
            bar(cohData.dates-min(cohData.dates)+1,cohData.numTrialsByDate);
            xlabel('num days','FontName','Times New Roman','FontSize',12);
            ylabel('num trials','FontName','Times New Roman','FontSize',12);
            
            % performance by day
            ax2 = subplot(3,2,2); hold on;
            plot([0 max(cohData.dates)-min(cohData.dates)+1],[0.5 0.5],'k');
            plot([0 max(cohData.dates)-min(cohData.dates)+1],[0.7 0.7],'k--');
            for i = 1:length(cohData.dates)
                if ~isnan(cohData.dayMetCutOffCriterion(i))
                    if cohData.dayMetCutOffCriterion(i)
                        xloc = cohData.dates(i)-min(cohData.dates)+1;
                        plot(xloc,cohData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor','k','MarkerFaceColor','k');
                        plot([xloc xloc],cohData.performanceByDate(2:3,i),'color','k','LineWidth',2);
                    else
                        xloc = cohData.dates(i)-min(cohData.dates)+1;
                        plot(xloc,cohData.performanceByDate(1,i),'Marker','d','MarkerEdgeColor',0.75*[1 1 1],'MarkerFaceColor',0.75*[1 1 1]);
                        plot([xloc xloc],cohData.performanceByDate(2:3,i),'color',0.75*[1 1 1],'LineWidth',2);
                    end
                else
                    xloc = cohData.dates(i)-min(cohData.dates)+1;
                    plot(xloc,0.5,'Marker','x','color','k');
                end
            end
            set(ax2,'ylim',[0.2 1]);
            xlabel('day num','FontName','Times New Roman','FontSize',12);
            ylabel('performance','FontName','Times New Roman','FontSize',12);
            
            % performance by condition
            ax3 = subplot(3,2,3:4); hold on;
            conditionColor = {'b','r','b','r','k'};
            for i = 1:size(cohData.performanceByConditionWCO,3)
                for j = 1:size(cohData.performanceByConditionWCO,1)
                    if ~isnan(cohData.performanceByConditionWCO(j,1,i))
                        plot(cohData.contrasts(j),cohData.performanceByConditionWCO(j,1,i),'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
                        plot([cohData.contrasts(j) cohData.contrasts(j)],[cohData.performanceByConditionWCO(j,2,i) cohData.performanceByConditionWCO(j,3,i)],'color',conditionColor{i},'linewidth',5);
                    end
                end
            end
            set(ax3,'ylim',[0.2 1.1],'xlim',[-0.05 1.05],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0.2 0.5 1],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
            xlabel('contrast','FontName','Times New Roman','FontSize',12);
            ylabel('performance','FontName','Times New Roman','FontSize',12);
                        
            % response times
            ax4 = subplot(3,2,5); hold on;
            conditionColor = {'b','r','b','r','k'};
            for i = 1:size(cohData.responseTimesByConditionWCO,2)
                for j = 1:size(cohData.responseTimesByConditionWCO,1)
                    if ~(isempty(cohData.responseTimesByConditionWCO{j,i}))
                        m = mean(cohData.responseTimesByConditionWCO{j,i});
                        sem = std(cohData.responseTimesByConditionWCO{j,i})/sqrt(length(cohData.responseTimesByConditionWCO{j,i}));
                        plot(cohData.contrasts(j),m,'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
                        plot([cohData.contrasts(j) cohData.contrasts(j)],[m-sem m+sem],'color',conditionColor{i},'linewidth',5);
                    end
                end
            end
            set(ax4,'ylim',[0 3],'xlim',[-0.05 1.05],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0 1 2 3],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
            xlabel('contrast','FontName','Times New Roman','FontSize',12);
            ylabel('responseTime','FontName','Times New Roman','FontSize',12);
            
            % response times for correct
            ax5 = subplot(3,2,6); hold on;
            conditionColor = {'b','r','b','r','k'};
            for i = 1:size(cohData.responseTimesForCorrectByConditionWCO,2)
                for j = 1:size(cohData.responseTimesForCorrectByConditionWCO,1)
                    if ~(isempty(cohData.responseTimesForCorrectByConditionWCO{j,i}))
                        m = mean(cohData.responseTimesForCorrectByConditionWCO{j,i});
                        sem = std(cohData.responseTimesForCorrectByConditionWCO{j,i})/sqrt(length(cohData.responseTimesForCorrectByConditionWCO{j,i}));
                        plot(cohData.contrasts(j),m,'Marker','d','MarkerSize',10,'MarkerFaceColor',conditionColor{i},'MarkerEdgeColor','none');
                        plot([cohData.contrasts(j) cohData.contrasts(j)],[m-sem m+sem],'color',conditionColor{i},'linewidth',5);
                    end
                end
            end
            set(ax5,'ylim',[0 3],'xlim',[-0.05 1.05],'xtick',[0 0.25 0.5 0.75 1],'ytick',[0 1 2 3],'FontName','Times New Roman','FontSize',12);plot([0 1],[0.5 0.5],'k-');plot([0 1],[0.7 0.7],'k--');
            xlabel('contrast','FontName','Times New Roman','FontSize',12);
            ylabel('responseTimeForCorrect','FontName','Times New Roman','FontSize',12);
    end
end