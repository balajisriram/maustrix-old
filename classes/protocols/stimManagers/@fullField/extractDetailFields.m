function [out newLUT]=extractDetailFields(sm,basicRecords,trialRecords,LUTparams)
newLUT=LUTparams.compiledLUT;

try
    stimDetails=[trialRecords.stimDetails];
    [out.correctionTrial newLUT] = extractFieldAndEnsure(stimDetails,{'correctionTrial'},'scalar',newLUT);
    [out.pctCorrectionTrials newLUT] = extractFieldAndEnsure(stimDetails,{'pctCorrectionTrials'},'scalar',newLUT);
    [out.duration newLUT] = extractFieldAndEnsure(stimDetails,{'duration'},'scalar',newLUT);
    [out.repetitions newLUT] = extractFieldAndEnsure(stimDetails,{'repetitions'},'scalar',newLUT);

catch ex
    out=handleExtractDetailFieldsException(sm,ex,trialRecords);
    verifyAllFieldsNCols(out,length(trialRecords));
    return
end

verifyAllFieldsNCols(out,length(trialRecords));
end