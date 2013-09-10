function V1LesionPaperFigures

plotFigure1 = true;

if plotFigure1
    %$ basic analysis
    clc;
    disp('Figure1a is a schematic');
    
    % plotting the training for a Opt for this mouse
    mouseID = '26';
    filters = 735150:735180;
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'learningProcess';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    
    out = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    %% time to threshold for or
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.requestedPlot = 'learningProcessOnlyAverage';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    
    % 22,23,25,26,48,40,47,53,56,59,37,38,45,50
    
    % 22
    filters = 1:today;
    out = {};
    plotDetails.axHan = subplot(3,5,1); out{1} = analyzeMouse('22',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,2); out{2} = analyzeMouse('23',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,3); out{3} = analyzeMouse('25',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,4); out{4} = analyzeMouse('26',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,5); out{5} = analyzeMouse('48',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,6); out{6} = analyzeMouse('40',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,7); out{7} = analyzeMouse('47',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,8); out{8} = analyzeMouse('53',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,9); out{9} = analyzeMouse('56',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,10); out{10} = analyzeMouse('59',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,11); out{11} = analyzeMouse('37',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,12); out{12} = analyzeMouse('38',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,13); out{13} = analyzeMouse('45',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,14); out{14} = analyzeMouse('50',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
        
    %% actual plotting for or
    outFilter = logical([1 1 1 1 0 1 1 1 1 1 1 1 1 1]);
    filteredOut = out(outFilter);
    filteredOut = [filteredOut{:}];
    filteredOut = [filteredOut.optData];
    trialsToThresh = [filteredOut.trialsToThreshold];
    daysToThresh = [filteredOut.dayNumAtThreshold];
    % 
    
    figToBeSaved = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    subplot(2,1,1); hold on
    n=length(trialsToThresh);
    mTTT = mean(trialsToThresh);
    semTTT = std(trialsToThresh)/sqrt(n);
    plot(2.25,[trialsToThresh],'ko')
    plot(2.75,mTTT,'kd')
    plot(2.75,[mTTT-semTTT mTTT+semTTT],'k')
    plot([2.75 2.75],[mTTT-semTTT mTTT+semTTT],'k')
    ylabel('trials to thresh.')
    set(gca,'xlim',[0 3],'ylim',[0 7000],'xticklabel',[],'ytick',[2000 4000 6000],'yticklabel',[2 4 6])
    
    
    subplot(2,1,2)
    hold on;
    mDTT = mean(daysToThresh);
    stdDTT = std(daysToThresh);
    semDTT = stdDTT/sqrt(n);
    plot(2.25,daysToThresh,'ko')
    plot(2.75,mDTT,'kd')
    plot([2.75 2.75],[mDTT-semDTT mDTT+semDTT],'k')
    set(gca,'xlim',[0 3],'ylim',[0 70],'xticklabel',[],'ytick',[20 40 60],'yticklabel',[20 40 60]);
    ylabel('days to thresh.')
        
    %% time to threshold for object
    figure
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.requestedPlot = 'learningProcessOnlyAverage';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = true;
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    
    filters = 1:today;
    out = {};
    plotDetails.axHan = subplot(3,5,1); out{1} = analyzeMouse('22',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,2); out{2} = analyzeMouse('23',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,3); out{3} = analyzeMouse('25',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,4); out{4} = analyzeMouse('26',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,5); out{5} = analyzeMouse('48',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,6); out{6} = analyzeMouse('40',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,7); out{7} = analyzeMouse('47',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,8); out{8} = analyzeMouse('53',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,9); out{9} = analyzeMouse('56',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,10); out{10} = analyzeMouse('59',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,11); out{11} = analyzeMouse('37',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,12); out{12} = analyzeMouse('38',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,13); out{13} = analyzeMouse('45',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    plotDetails.axHan = subplot(3,5,14); out{14} = analyzeMouse('50',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
        
    %% actual plotting for images
    
    outFilter = logical([0 0 0 1 1 1 1 1 1 1 1 1 1 1]);
    filteredOut = out(outFilter);
    filteredOut = [filteredOut{:}];
    filteredOut = [filteredOut.imageData];
    trialsToThresh = [filteredOut.trialsToThreshold];
    daysToThresh = [filteredOut.dayNumAtThreshold];
    
    
    figure(figToBeSaved);
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    subplot(2,1,1); hold on
    n=length(trialsToThresh);
    mTTT = mean(trialsToThresh);
    semTTT = std(trialsToThresh)/sqrt(n);
    plot(0.25,[trialsToThresh],'ko')
    plot(0.75,mTTT,'kd')
    plot(0.75,[mTTT-semTTT mTTT+semTTT],'k')
    plot([0.75 0.75],[mTTT-semTTT mTTT+semTTT],'k')
    ylabel('trials to thresh.')
    set(gca,'xlim',[0 3],'ylim',[0 7000],'xticklabel',[],'ytick',[2000 4000 6000],'yticklabel',[2 4 6])
    
    
    subplot(2,1,2)
    hold on;
    mDTT = mean(daysToThresh);
    stdDTT = std(daysToThresh);
    semDTT = stdDTT/sqrt(n);
    plot(0.25,daysToThresh,'ko')
    plot(0.75,mDTT,'kd')
    plot([0.75 0.75],[mDTT-semDTT mDTT+semDTT],'k')
    set(gca,'xlim',[0 3],'ylim',[0 70],'xticklabel',[],'ytick',[20 40 60],'yticklabel',[20 40 60]);
    ylabel('days to thresh.')
    
    %% plot contrast
    figure
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.requestedPlot = 'performanceByCondition';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = true;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    
    filters = 1:today;
    out = {};
    filters = 1:datenum('Jan-15-2013');plotDetails.axHan = subplot(3,5,1); out{1} = analyzeMouse('22',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     plotDetails.axHan = subplot(3,5,2); out{2} = analyzeMouse('23',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jan-15-2013');plotDetails.axHan = subplot(3,5,3); out{3} = analyzeMouse('25',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Apr-19-2013');plotDetails.axHan = subplot(3,5,4); out{4} = analyzeMouse('26',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Apr-19-2013'); plotDetails.axHan = subplot(3,5,5); out{5} = analyzeMouse('48',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jan-15-2013');plotDetails.axHan = subplot(3,5,6); out{6} = analyzeMouse('40',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     plotDetails.axHan = subplot(3,5,7); out{7} = analyzeMouse('47',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('May-15-2013');plotDetails.axHan = subplot(3,5,8); out{8} = analyzeMouse('53',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('May-17-2013');plotDetails.axHan = subplot(3,5,9); out{9} = analyzeMouse('56',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     filters = 1:datenum('May-17-2013');plotDetails.axHan = subplot(3,5,10); out{10} = analyzeMouse('59',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jun-25-2013');plotDetails.axHan = subplot(3,5,11); out{11} = analyzeMouse('37',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jun-25-2013');plotDetails.axHan = subplot(3,5,12); out{12} = analyzeMouse('38',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jul-1-2013');plotDetails.axHan = subplot(3,5,13); out{13} = analyzeMouse('45',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jul-1-2013');plotDetails.axHan = subplot(3,5,14); out{14} = analyzeMouse('50',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    %% lets replot that on the same graph
    fighan = figure
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.requestedPlot = 'performanceByCondition';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = true;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    axHan = axes;
    out = {};
    plotDetails.plotMeansOnly = true;
    filters = 1:datenum('Jan-15-2013');plotDetails.axHan = axHan; out{1} = analyzeMouse('22',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     plotDetails.axHan = subplot(3,5,2); out{2} = analyzeMouse('23',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jan-15-2013');plotDetails.axHan = axHan; out{3} = analyzeMouse('25',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Apr-19-2013');plotDetails.axHan = axHan; out{4} = analyzeMouse('26',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Apr-19-2013'); plotDetails.axHan = axHan; out{5} = analyzeMouse('48',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jan-15-2013');plotDetails.axHan = axHan; out{6} = analyzeMouse('40',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     plotDetails.axHan = subplot(3,5,7); out{7} = analyzeMouse('47',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('May-15-2013');plotDetails.axHan = axHan; out{8} = analyzeMouse('53',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('May-17-2013');plotDetails.axHan = axHan; out{9} = analyzeMouse('56',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     filters = 1:datenum('May-17-2013');plotDetails.axHan = axHan; out{10} = analyzeMouse('59',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jun-25-2013');plotDetails.axHan = axHan; out{11} = analyzeMouse('37',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jun-25-2013');plotDetails.axHan = axHan; out{12} = analyzeMouse('38',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jul-1-2013');plotDetails.axHan = axHan; out{13} = analyzeMouse('45',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:datenum('Jul-1-2013');plotDetails.axHan = axHan; out{14} = analyzeMouse('50',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    plotDetails.plotMeansOnly = false;
    compiledFilesDirs = {compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,...
        compiledFilesDir,compiledFilesDir,compiledFilesDir};
    filters = 1:today;plotDetails.axHan = axHan; outTotal = analyzeMouse({'22','25','26','48','40','53','56','37','38','45','50'},filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDirs);
    
    %% and now orientation
    
    %% lets replot that on the same graph
    fighan = figure
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.requestedPlot = 'performanceByCondition';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = false;
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = true;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    axHan = axes;
    out = {};
    plotDetails.plotMeansOnly = true;
%     filters = 1:datenum('Jan-15-2013');plotDetails.axHan = axHan; out{1} = analyzeMouse('22',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{2} = analyzeMouse('23',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{3} = analyzeMouse('25',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeRevOrientation = true;analysisFor.analyzeOrientation = false;filters = 1:today;plotDetails.axHan = axHan; out{4} = analyzeMouse('26',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeRevOrientation = false;analysisFor.analyzeOrientation = true;filters = 1:today; plotDetails.axHan = axHan; out{5} = analyzeMouse('48',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{6} = analyzeMouse('40',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{7} = analyzeMouse('47',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{8} = analyzeMouse('53',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{9} = analyzeMouse('56',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{10} = analyzeMouse('59',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{11} = analyzeMouse('37',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{12} = analyzeMouse('38',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{13} = analyzeMouse('45',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    filters = 1:today;plotDetails.axHan = axHan; out{14} = analyzeMouse('50',filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    plotDetails.plotMeansOnly = false;
    compiledFilesDirs = {compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,...
        compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir,compiledFilesDir};
    filters = 1:today;plotDetails.axHan = axHan; outTotal = analyzeMouse({'23','25','26','48','40','47','53','56','59','37','38','45','50'},filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDirs);
  
end

if plotFigure2
    %% 26  performance by day
    clc;
    disp('Figure1a is a schematic');
    
    % plotting the training for a Opt for this mouse
    mouseID = '26';
    filters = 1:today;
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'givenAxes';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'performanceByDay';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;% true, false
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = true; % true, false
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    
    out = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    %% lets look and find te lesionm dates
    
    clc;
    disp('Figure1a is a schematic');
    
    % plotting the training for a Opt for this mouse
    filters = 1:today;
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'makeFigure';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'performanceByDay';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;% true, false
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false; % true, false
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    out = {};
    numDaysBefore = 10;
    mouseID = '22'; filters = datenum('Jan-20-2013')-5:today;out{1} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '23'; filters = datenum('Jan-14-2013')-5:today;out{2} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '25'; filters = datenum('Jan-14-2013')-5:today;out{3} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = true;
    mouseID = '26'; filters = datenum('Apr-22-2013')-5:today;out{4} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    mouseID = '48'; filters = datenum('Apr-22-2013')-5:today;out{5} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '40'; filters = datenum('May-15-2013')-5:today;out{6} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '47'; filters = datenum('May-15-2013')-5:today;out{7} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '53'; filters = datenum('May-15-2013')-5:today;out{8} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '56'; filters = datenum('May-12-2013')-5:today;out{9} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '59'; filters = datenum('May-17-2013')-5:today;out{10} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '37'; filters = datenum('Jun-25-2013')-5:today;out{11} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '38'; filters = datenum('Jun-25-2013')-5:today;out{12} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '45'; filters = datenum('Jul-1-2013')-5:today;out{13} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '50'; filters = datenum('Jul-1-2013')-5:today;out{14} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    
    %% lesion before and after
    
    clc;
    disp('Figure1a is a schematic');
    
    % plotting the training for a Opt for this mouse
    filters = 1:today;
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = false;
    plotDetails.plotWhere = 'makeFigure';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'performanceByDay';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = false;% true, false
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false; % true, false
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    out = {};
    beforePerf = nan(14,1);
    nBefore = nan(14,1);
    afterPerf = nan(14,1);
    nAfter = nan(14,1);
    beforeLCI = nan(14,1);
    beforeHCI = nan(14,1);
    afterLCI = nan(14,1);
    afterHCI = nan(14,1);
    
    mouseID = '22'; filters = datenum('Jan-20-2013')-5:datenum('Jan-20-2013');out{1} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '23'; filters = datenum('Jan-14-2013')-5:datenum('Jan-14-2013');out{2} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '25'; filters = datenum('Jan-14-2013')-5:datenum('Jan-14-2013');out{3} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = true;
    mouseID = '26'; filters = datenum('Apr-22-2013')-5:datenum('Apr-22-2013');out{4} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    mouseID = '48'; filters = datenum('Apr-22-2013')-5:datenum('Apr-22-2013');out{5} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '40'; filters = datenum('May-15-2013')-5:datenum('May-15-2013');out{6} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '47'; filters = datenum('May-15-2013')-5:datenum('May-15-2013');out{7} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '53'; filters = datenum('May-15-2013')-5:datenum('May-15-2013');out{8} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '56'; filters = datenum('May-12-2013')-5:datenum('May-12-2013');out{9} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '59'; filters = datenum('May-17-2013')-5:datenum('May-17-2013');out{10} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '37'; filters = datenum('Jun-25-2013')-5:datenum('Jun-25-2013');out{11} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '38'; filters = datenum('Jun-25-2013')-5:datenum('Jun-25-2013');out{12} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '45'; filters = datenum('Jul-1-2013')-5:datenum('Jul-1-2013');out{13} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '50'; filters = datenum('Jul-1-2013')-5:datenum('Jul-1-2013');out{14} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    for i = [1:3 5:14]
        beforePerf(i) = out{i}.optData.performanceByConditionWCO(1,5);
        beforeLCI(i) = out{i}.optData.performanceByConditionWCO(2,5);
        beforeHCI(i) = out{i}.optData.performanceByConditionWCO(3,5);
        nBefore(i) = out{i}.optData.numTrialsByConditionWCO{5};
    end
    beforePerf(4) = out{4}.optReversalData.performanceByConditionWCO(1,5);
    beforeLCI(4) = out{4}.optReversalData.performanceByConditionWCO(2,5);
    beforeHCI(4) = out{4}.optReversalData.performanceByConditionWCO(3,5);
    nBefore(4) = out{4}.optReversalData.numTrialsByConditionWCO{5};
    
    
    mouseID = '22'; filters = datenum('Jan-20-2013'):today;out{1} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '23'; filters = datenum('Jan-14-2013'):today;out{2} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '25'; filters = datenum('Jan-14-2013'):today;out{3} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = true;
    mouseID = '26'; filters = datenum('Apr-22-2013'):today;out{4} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    analysisFor.analyzeOpt = true;
    analysisFor.analyzeRevOpt = false;
    mouseID = '48'; filters = datenum('Apr-22-2013'):today;out{5} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '40'; filters = datenum('May-15-2013'):today;out{6} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '47'; filters = datenum('May-15-2013'):today;out{7} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '53'; filters = datenum('May-15-2013'):today;out{8} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '56'; filters = datenum('May-12-2013'):today;out{9} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '59'; filters = datenum('May-17-2013'):today;out{10} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '37'; filters = datenum('Jun-25-2013'):today;out{11} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '38'; filters = datenum('Jun-25-2013'):today;out{12} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '45'; filters = datenum('Jul-1-2013'):today;out{13} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '50'; filters = datenum('Jul-1-2013'):today;out{14} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    for i = [1:3 5:14]
        afterPerf(i) = out{i}.optData.performanceByConditionWCO(1,5);
        afterLCI(i) = out{i}.optData.performanceByConditionWCO(2,5);
        afterHCI(i) = out{i}.optData.performanceByConditionWCO(3,5);
        nAfter(i) = out{i}.optData.numTrialsByConditionWCO{5};
    end
    afterPerf(4) = out{4}.optReversalData.performanceByConditionWCO(1,5);
    afterLCI(4) = out{4}.optReversalData.performanceByConditionWCO(2,5);
    afterHCI(4) = out{4}.optReversalData.performanceByConditionWCO(3,5);
    nAfter(4) = out{4}.optReversalData.numTrialsByConditionWCO{5};
    
     %% lesioning image data
    
    clc;
    
    % plotting the training for a Opt for this mouse
    filters = 1:today;
    
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = true;
    plotDetails.plotWhere = 'makeFigure';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'performanceByDay';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = true;% true, false
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = false; % true, false
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    out = {};
    numDaysBefore = 10;
    mouseID = '22'; filters = datenum('Jan-20-2013')-100:today;out{1} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '23'; filters = datenum('Jan-14-2013')-50:today;out{2} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     mouseID = '25'; filters = datenum('Jan-14-2013')-50:today;out{3} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '26'; filters = datenum('Apr-22-2013')-15:today;out{4} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '48'; filters = datenum('Apr-22-2013')-15:today;out{5} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '40'; filters = datenum('May-15-2013')-15:today;out{6} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '47'; filters = datenum('May-15-2013')-15:today;out{7} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '53'; filters = datenum('May-15-2013')-35:today;out{8} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '56'; filters = datenum('May-12-2013')-15:today;out{9} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '59'; filters = datenum('May-17-2013')-20:today;out{10} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '37'; filters = datenum('Jun-25-2013')-15:today;out{11} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '38'; filters = datenum('Jun-25-2013')-15:today;out{12} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '45'; filters = datenum('Jul-1-2013')-15:today;out{13} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '50'; filters = datenum('Jul-1-2013')-15:today;out{14} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    %% lesion before and after images
    
    clc;
        
    fighan = figure;
    set(fighan, 'DefaultTextFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontSize', 12); % [pt]
    set(fighan, 'DefaultAxesFontName', 'Times New Roman');
    set(fighan, 'DefaultTextFontName', 'Times New Roman');
    
    
    plotDetails.plotOn = false;
    plotDetails.plotWhere = 'makeFigure';
    plotDetails.axHan = axes;
    plotDetails.requestedPlot = 'performanceByDay';
    
    trialNumCutoff = 25;
    
    analysisFor.analyzeImages = true;% true, false
    analysisFor.analyzeOpt = false;
    analysisFor.analyzeRevOpt = false; % true, false
    analysisFor.analyzeContrast = false;
    analysisFor.analyzeRevContrast = false;
    analysisFor.analyzeSpatFreq = false;
    analysisFor.analyzeRevSpatFreq = false;
    analysisFor.analyzeOrientation = false;
    analysisFor.analyzeRevOrientation = false;
    analysisFor.analyzeTempFreq = false;
    analysisFor.analyzeRevTempFreq = false;
    
    if ismac
        compiledFilesDir = '/Volumes/BAS-DATA1/BehaviorBkup/Box3/Compiled';
    elseif IsWin
        compiledFilesDir = '\\ghosh-16-159-221.ucsd.edu\ghosh\Behavior\V1Lesion\Compiled';
    end
    out = {};
    beforePerf = nan(14,1);
    nBefore = nan(14,1);
    afterPerf = nan(14,1);
    nAfter = nan(14,1);
    beforeLCI = nan(14,1);
    beforeHCI = nan(14,1);
    afterLCI = nan(14,1);
    afterHCI = nan(14,1);
    
    mouseID = '22'; filters = datenum('Jan-20-2013')-100:datenum('Jan-20-2013');out{1} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '23'; filters = datenum('Jan-14-2013')-50:datenum('Jan-14-2013');out{2} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     mouseID = '25'; filters = datenum('Jan-14-2013')-50:datenum('Jan-14-2013');out{3} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '26'; filters = datenum('Apr-22-2013')-15:datenum('Apr-22-2013');out{4} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '48'; filters = datenum('Apr-22-2013')-15:datenum('Apr-22-2013');out{5} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '40'; filters = datenum('May-15-2013')-15:datenum('May-15-2013');out{6} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '47'; filters = datenum('May-15-2013')-15:datenum('May-15-2013');out{7} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '53'; filters = datenum('May-15-2013')-35:datenum('May-15-2013');out{8} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '56'; filters = datenum('May-12-2013')-15:datenum('May-12-2013');out{9} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '59'; filters = datenum('May-17-2013')-20:datenum('May-17-2013');out{10} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '37'; filters = datenum('Jun-25-2013')-15:datenum('Jun-25-2013');out{11} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '38'; filters = datenum('Jun-25-2013')-15:datenum('Jun-25-2013');out{12} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '45'; filters = datenum('Jul-1-2013')-15:datenum('Jul-1-2013');out{13} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '50'; filters = datenum('Jul-1-2013')-15:datenum('Jul-1-2013');out{14} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    for i = [1:2 4:14]
        beforePerf(i) = out{i}.imageData.performanceByConditionWCO(1,5);
        beforeLCI(i) = out{i}.imageData.performanceByConditionWCO(2,5);
        beforeHCI(i) = out{i}.imageData.performanceByConditionWCO(3,5);
        nBefore(i) = out{i}.imageData.numTrialsByConditionWCO{5};
    end
    
    out = {};
    mouseID = '22'; filters = datenum('Jan-20-2013'):today;out{1} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '23'; filters = datenum('Jan-14-2013'):today;out{2} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
%     mouseID = '25'; filters = datenum('Jan-14-2013'):today;out{3} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '26'; filters = datenum('Apr-22-2013'):today;out{4} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '48'; filters = datenum('Apr-22-2013'):today;out{5} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '40'; filters = datenum('May-15-2013'):today;out{6} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '47'; filters = datenum('May-15-2013'):today;out{7} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '53'; filters = datenum('May-15-2013'):today;out{8} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '56'; filters = datenum('May-12-2013'):today;out{9} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '59'; filters = datenum('May-17-2013'):today;out{10} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '37'; filters = datenum('Jun-25-2013'):today;out{11} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '38'; filters = datenum('Jun-25-2013'):today;out{12} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '45'; filters = datenum('Jul-1-2013'):today;out{13} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    mouseID = '50'; filters = datenum('Jul-1-2013'):today;out{14} = analyzeMouse(mouseID,filters,plotDetails,trialNumCutoff,analysisFor,[],compiledFilesDir);
    
    for i = [1:2 4:14]
        afterPerf(i) = out{i}.imageData.performanceByConditionWCO(1,5);
        afterLCI(i) = out{i}.imageData.performanceByConditionWCO(2,5);
        afterHCI(i) = out{i}.imageData.performanceByConditionWCO(3,5);
        nAfter(i) = out{i}.imageData.numTrialsByConditionWCO{5};
    end

    %%
    LesionDetails = {
        '22',   'Jan-15-2013',  'Mech';
        '23',   'Jan-15-2013',  'Mech';
        '25',   'Jan-15-2013',  'Mech';
        '26',   'Apr-19-2013',  'IBO';
        '48',   'Apr-19-2013',  'IBO';
        '40',   'May-15-2013',  'IBO';
        '47',   'May-15-2013',  'IBO';
        '53',   'May-15-2013',  'IBO';
        '56',   'May-17-2013',  'Mech';
        '59',   'May-17-2013',  'Mech';
        '37',   'Jun-25-2013',  'Mech';
        '38',   'Jun-25-2013',  'Mech';
        '45',   'Jul-1-2013',   'IBO';
        '50',   'Jul-1-2013',   'IBO'};
    
end