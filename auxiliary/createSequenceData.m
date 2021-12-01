% create complete sequence data set for analysis

function createSequenceData(fs, numberFrequencyPoints, sequenceLengthMiliseconds, totalDecayDB, numberOfPulsesList)

load('collectData.mat', 'data');
len = sequenceLengthMiliseconds * 1e-3 * fs;
numberOfSequences = size(data.("improved" + num2str(numberOfPulsesList(1))).pulseGain, 2);

conditions = cell(1, length(numberOfPulsesList));
dataFields = conditions;
for it = 1:length(numberOfPulsesList)
    conditions{it} = ['oVND', num2str(numberOfPulsesList(it))];
    dataFields{it} = ['improved', num2str(numberOfPulsesList(it))];
end
conditions = [conditions, {'eVND', 'WNS'}];
dataFields = [dataFields, {['initial', num2str(max(numberOfPulsesList))], 'none'}];

numberConditions = length(conditions);

for it = 1:numberConditions
    cond = conditions{it};
    disp(cond)
    
    if strcmp(cond, 'WNS')
        sequence = zeros(len,numberOfSequences);
        for itSeq = 1:numberOfSequences
            sequence(:,itSeq) = VND_wndecorr(len,totalDecayDB);
        end
    else % oVND, eVND
        field = dataFields{it};
        pulseGain = data.(field).pulseGain;
        pulseTime = data.(field).pulseTime;
        
        sequence = closestVND(pulseTime,pulseGain, fs);
        sequence = sequence(1:len,:);
    end
    
    sequence = sequence ./ sqrt(sum(sequence.^2,1));
    
    [smooth,~] = thirdOctaveSmooth(sequence,numberFrequencyPoints,fs);
    
    m = mean(smooth,1);
    error = sqrt(mean((smooth - m ).^2,1));
    
    [~, index] = sort(error,'ascend');
    
    switch cond
        case conditions{length(numberOfPulsesList)}
            indexOVNmax = index;
        case 'eVND'
            index = indexOVNmax;
    end
            
    local.(cond).sequence = sequence(:,index);
    local.(cond).smooth = smooth(:,index);
    local.(cond).error = error(:,index);
    
    [coherenceFreq, local.(cond).coherence] = coherence(local.(cond).sequence, fs);
     
end

dataSet = local;
save('./data/sequenceData.mat','dataSet','conditions','fs','coherenceFreq');






