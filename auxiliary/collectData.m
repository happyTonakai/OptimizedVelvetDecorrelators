% collect temporary data into a single mat file
%
% Sebastian J. Schlecht, Thursday, 20 February 2020

function collectData(numberOfPulsesList)
    % fileName = mfilename;

    %% collect trails
    d = [];

    for itPulses = 1:length(numberOfPulsesList)
        numberOfPulses = numberOfPulsesList(itPulses);

        listing = dir(['./temporary/' num2str(numberOfPulses) '*.mat']);
        numberOfTrails = length(listing);

        conditions = {'improved', 'initial'};

        for it = 1:numberOfTrails

            filename = listing(it).name;
            load(['./temporary/' filename], 'data');

            for cond = conditions
                c = cond{1};

                targetCond = [c num2str(numberOfPulses)];
                d.(targetCond).pulseTime(:, it) = data.(c).pulseTime;
                d.(targetCond).pulseGain(:, it) = data.(c).pulseGain;

            end

        end

    end

    data = d;
    save('./data/collectData.mat', 'data');
end
