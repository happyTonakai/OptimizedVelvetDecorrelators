% search for best VND
%
% Author: Sebastian J. Schlecht
% Date: 12/03/2018

function search_bestVND(fs, numberFrequencyPoints, sequenceLengthMiliseconds, totalDecayDB, numberOfPulsesList, numberOfTrails)

    global smoothingWindow;
    load('smoothWin.mat', 'Win');
    smoothingWindow = Win;

    for itPulse = 1:length(numberOfPulsesList)
        numberOfPulses = numberOfPulsesList(itPulse);

        for it = 1:numberOfTrails
            data = [];

            %% Improve VND
            [data.improved.pulseTime, data.improved.pulseGain, data.initial.pulseTime, data.initial.pulseGain] = ...
                improveVND(numberOfPulses, sequenceLengthMiliseconds, totalDecayDB, numberFrequencyPoints, fs);

            %% disp and save
            disp(it);
            save(['./temporary/' num2str(numberOfPulses) '_' num2str(rand * 1000000, '%07.f') '.mat'], 'data');
        end

    end

end
