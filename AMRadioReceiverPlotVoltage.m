% Code to plot simulation results from AMRadioReceiver
%% Plot Description:
%
% The plots below shows received, amplified, and output signals in the
% radio receiver.  As the resonance in the resonant circuit passes
% through 600kHz, the signal is picked up and amplified by a two-stage
% Class A RF power amplifier.

% Copyright 2016-2023 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_AMRadioReceiver', 'var') || ...
        simlogNeedsUpdate(simlog_AMRadioReceiver, 'AMRadioReceiver') 
    sim('AMRadioReceiver')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_AMRadioReceiver', 'var') || ...
        ~isgraphics(h1_AMRadioReceiver, 'figure')
    h1_AMRadioReceiver = figure('Name', 'AMRadioReceiver');
end
figure(h1_AMRadioReceiver)
clf(h1_AMRadioReceiver)

% Get simulation results
simlog_t = simlog_AMRadioReceiver.R.n.v.series.time;
simlog_vraw = simlog_AMRadioReceiver.R.n.v.series.values('V');
simlog_vamp = simlog_AMRadioReceiver.Ccoupling2.n.v.series.values('V');
simlog_vout = simlog_AMRadioReceiver.Diode_Detector.Diode.n.v.series.values('V');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_vout, 'LineWidth', 1)
grid on
title('Output Signal')
ylabel('Voltage (V)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_vamp, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_vraw, 'LineWidth', 1)
hold off
grid on
title('Radio Signals')
ylabel('Voltage (V)')
xlabel('Time (s)')
legend({'Amplified','Received'},'Location','Best');

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_vamp simlog_vout simlog_vraw
