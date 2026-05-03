%% plot_fft_modes.m
% Frequency-domain analysis of vehicle dynamics signals using fft_VD.m.
%
% The four .mat files in results/data/ were generated from handling-focused
% simulations and log handling signals (SWA, latacc, sideslip, yawrate, X/Y),
% NOT ride/vertical signals. So this script does:
%   - FFT of yaw rate          → identifies yaw natural frequency (typically 0.5–2 Hz)
%   - FFT of lateral acceleration → handling-response spectrum
%
% Writes: ./fig_fft_yaw_response.png
%         ./fig_fft_lateral_response.png
%
% Run:
%   cd figures
%   addpath(genpath('../shared'))
%   plot_fft_modes
%
% ----------------------------------------------------------------------
% TO GET TRUE BODY-MODE + WHEEL-HOP FFT
% (1–3 Hz body modes, 10–18 Hz wheel-hop)
% you need ride-domain signals like `sprung_z` and `unsprung_z` from a
% shaker-rig simulation. Run the 7-DoF or 10-DoF shaker model
% (03_dof7_shaker/Suspension_shaker_rig_model.slx or
%  04_dof10_shaker/DOF10_Suspension_shaker_rig_model.slx),
% log the vertical signals to To-Workspace blocks, save the .mat, and
% then point this script at it with the appropriate signal names.
% ----------------------------------------------------------------------

clear; close all;
addpath('../shared');

%% Load (using road-car run as the example data source)
src = load('../results/data/out_roadcar.mat');
src = src.out;

%% --- Yaw-rate FFT (handling response) ---
SIGNAL_YAW = 'yawrate';
[t, y] = get_signal(src, SIGNAL_YAW);
if ~isempty(y)
    dt = mean(diff(t));
    [amp, ~, freq] = fft_VD(y - mean(y), dt);

    fig1 = figure('Position', [100 100 900 460], 'Color', 'w');
    semilogy(freq, amp, 'LineWidth', 1.6);
    grid on; box on;
    xlim([0 5]);                 % handling-domain natural frequencies
    xlabel('Frequency [Hz]', 'FontSize', 11);
    ylabel('|Amplitude|', 'FontSize', 11);
    title(sprintf('Yaw rate — frequency response (FFT of %s)', SIGNAL_YAW), 'FontSize', 12);
    set(gca, 'FontSize', 10);
    drawnow;
    exportgraphics(fig1, 'fig_fft_yaw_response.png', 'Resolution', 150);
    fprintf('Wrote fig_fft_yaw_response.png\n');
end

%% --- Lateral-accel FFT (handling response) ---
SIGNAL_LAT = 'latacc';
[t, y] = get_signal(src, SIGNAL_LAT);
if ~isempty(y)
    dt = mean(diff(t));
    [amp, ~, freq] = fft_VD(y - mean(y), dt);

    fig2 = figure('Position', [100 100 900 460], 'Color', 'w');
    semilogy(freq, amp, 'LineWidth', 1.6);
    grid on; box on;
    xlim([0 5]);
    xlabel('Frequency [Hz]', 'FontSize', 11);
    ylabel('|Amplitude|', 'FontSize', 11);
    title(sprintf('Lateral acceleration — frequency response (FFT of %s)', SIGNAL_LAT), 'FontSize', 12);
    set(gca, 'FontSize', 10);
    drawnow;
    exportgraphics(fig2, 'fig_fft_lateral_response.png', 'Resolution', 150);
    fprintf('Wrote fig_fft_lateral_response.png\n');
end
