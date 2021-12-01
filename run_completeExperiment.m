% run complete experiment
%
% Sebastian J. Schlecht, Thursday, 20 February 2020
clear; clc; close all;

startup;

%% parameter setting
fs = 48000;
numberFrequencyPoints = 4096;
sequenceLengthMiliseconds = 30;
totalDecayDB = -60;
numberOfPulsesList = [60];
numberOfTrails = 50;
numberOfDecorrelators = 32; % numberOfDecorrelators <= numberOfTrails

%% optimization of velvet noise and collect data
search_bestVND(fs, numberFrequencyPoints, sequenceLengthMiliseconds, totalDecayDB, numberOfPulsesList, numberOfTrails);
collectData(numberOfPulsesList);

%% create data set for EVN, OVN30, OVN15, WN (sequence, smooth, error, coherence)
createSequenceData(fs, numberFrequencyPoints, sequenceLengthMiliseconds, totalDecayDB, numberOfPulsesList);

%% Select best sequences
write_multichannelDecorrelator(numberOfPulsesList, numberOfDecorrelators)

%% create plots
plot_coherenceAll
plot_exponentialDecayCurve
plot_integerSPSerror
plot_meanMagnitudeAll

