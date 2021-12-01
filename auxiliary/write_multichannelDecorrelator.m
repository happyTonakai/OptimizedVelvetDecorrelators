% select listening test sequences
function write_multichannelDecorrelator(numberOfPulsesList, numberOfDecorrelators)
    load('sequenceData.mat', 'dataSet', 'conditions');
    % numberConditions = length(conditions);

    % numberOfSequences = size(dataSet.oVND15.error,2);

    for it = 1:length(numberOfPulsesList)
        cond = conditions{it};

        if strcmp(cond, 'WNS')
            % sequenceIndex = round(linspace(1,numberOfSequences,numberOfDecorrelators));
        else % oVND
            sequenceIndex = 1:numberOfDecorrelators;
        end

        decorrelator.(cond) = dataSet.(cond).sequence(:, sequenceIndex);
    end

    save(['./data/decorrelator', num2str(numberOfDecorrelators), '.mat'], 'decorrelator');
end

% audiowrite('./data/decorrelator32_oVND30.wav', decorrelator.oVND30, Fs);
% audiowrite('./data/decorrelator32_oVND15.wav', decorrelator.oVND15, Fs);
%
% %% write stereo example
% [dry, fs] = audioread('NewGo_dry.wav');
% stereo(:,1) = conv(dry, decorrelator.oVND30(:,1));
% stereo(:,2) = conv(dry, decorrelator.oVND30(:,2));
% audiowrite('./data/NewGo_stereo.wav',stereo, fs);
