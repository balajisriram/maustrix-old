function [graduate, details] = checkCriterion(c,subject,trainingStep,trialRecords)

%determine what type trialRecord are
recordType='largeData'; %circularBuffer

thisStep=[trialRecords.trainingStepNum]==trialRecords(end).trainingStepNum;
trialsUsed=trialRecords(thisStep);

graduate=true;
if ~isempty(trialRecords)
    %get the correct vector
    switch recordType
        case 'largeData'
            dates = floor(datenum(cell2mat({trialsUsed.date}'))); % the actual dates of each trials
            stochastic = [trialsUsed.didStochasticResponse];
            humanResponse = [trialsUsed.didHumanResponse];
            forcedRewards = [trialsUsed.containedForcedRewards]==1;
            
            goodDates = dates(~stochastic | ~humanResponse & ~forcedRewards);
            daysRun = unique(dates);
            for i = length(daysRun):-1:length(daysRun)-c.consecutiveDays+1
                graduate = graduate && sum(goodDates==daysRun(i))>=c.trialsPerDay;
            end
        otherwise
            error('unknown trialRecords type')
    end

end


%play graduation tone

if graduate
    beep;
    pause(.2);
    beep;
    pause(.2);
    beep;
    pause(1);
    [junk stepNum]=getProtocolAndStep(subject);
    for i=1:stepNum+1
        beep;
        pause(.4);
    end
    if (nargout > 1)
        details.date = now;
        details.criteria = c;
        details.graduatedFrom = stepNum;
        details.allowedGraduationTo = stepNum + 1;
        details.trialsPerDay = c.trialsPerDay;
    end
end
end % end function