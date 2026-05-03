%% plot_aero_comparison.m
% Longitudinal/aero straight-line study — overlays vehicle response with
% original vs increased aero parameters.
%
% Signals logged in these .mat files (longitudinal-only):
%   v        — vehicle speed
%   longacc  — longitudinal acceleration
%   X        — longitudinal position
%   kappaf   — front-axle slip ratio
%   kappar   — rear-axle slip ratio
%
% Reads:  ../results/data/out_original_aero.mat
%         ../results/data/out_increased_aero.mat
% Writes: ./fig_aero_*.png
%
% Run:
%   cd figures
%   addpath(genpath('../shared'))
%   plot_aero_comparison

clear; close all;
addpath('../shared');

%% Load
orig = load('../results/data/out_original_aero.mat');
incr = load('../results/data/out_increased_aero.mat');
orig = orig.out;
incr = incr.out;

%% Time-history signals
SIGNALS = {
    'v',        'Vehicle speed [km/h]',                3.6;     % m/s -> km/h
    'longacc',  'Longitudinal acceleration [m/s^2]',   1.0;
    'X',        'Position X [m]',                      1.0;
    'kappaf',   'Front slip ratio [-]',                1.0;
    'kappar',   'Rear slip ratio [-]',                 1.0;
};

for k = 1:size(SIGNALS, 1)
    name  = SIGNALS{k, 1};
    label = SIGNALS{k, 2};
    scale = SIGNALS{k, 3};

    [t1, y1] = get_signal(orig, name);
    [t2, y2] = get_signal(incr, name);
    if isempty(y1) && isempty(y2), continue, end

    fig = figure('Position', [100 100 880 460], 'Color', 'w');
    if ~isempty(y1)
        plot(t1, y1*scale, 'LineWidth', 1.6, 'DisplayName', 'Original aero');
    end
    hold on;
    if ~isempty(y2)
        plot(t2, y2*scale, 'LineWidth', 1.6, 'DisplayName', 'Increased aero');
    end
    grid on; box on;
    xlabel('Time [s]', 'FontSize', 11);
    ylabel(label, 'FontSize', 11);
    title(sprintf('Aero comparison — %s', label), 'FontSize', 12);
    legend('Location', 'best');
    set(gca, 'FontSize', 10);
    drawnow;

    out_png = sprintf('fig_aero_%s.png', name);
    exportgraphics(fig, out_png, 'Resolution', 150);
    fprintf('Wrote %s\n', out_png);
end

%% Derived plot 1: speed vs distance (intuitive straight-line view)
[~, x1] = get_signal(orig, 'X');
[~, v1] = get_signal(orig, 'v');
[~, x2] = get_signal(incr, 'X');
[~, v2] = get_signal(incr, 'v');

have_orig = ~isempty(x1) && ~isempty(v1);
have_incr = ~isempty(x2) && ~isempty(v2);

if have_orig || have_incr
    fig = figure('Position', [100 100 880 460], 'Color', 'w');
    if have_orig
        plot(x1, v1*3.6, 'LineWidth', 1.6, 'DisplayName', 'Original aero');
    end
    hold on;
    if have_incr
        plot(x2, v2*3.6, 'LineWidth', 1.6, 'DisplayName', 'Increased aero');
    end
    grid on; box on;
    xlabel('Distance X [m]', 'FontSize', 11);
    ylabel('Vehicle speed [km/h]', 'FontSize', 11);
    title('Speed vs distance — aero comparison', 'FontSize', 12);
    legend('Location', 'best');
    set(gca, 'FontSize', 10);
    drawnow;
    exportgraphics(fig, 'fig_aero_speed_vs_distance.png', 'Resolution', 150);
    fprintf('Wrote fig_aero_speed_vs_distance.png\n');
end

%% Derived plot 2: longitudinal acceleration vs speed (THE aero plot)
% Shows where drag starts eating available longitudinal force.
[~, v1] = get_signal(orig, 'v');
[~, a1] = get_signal(orig, 'longacc');
[~, v2] = get_signal(incr, 'v');
[~, a2] = get_signal(incr, 'longacc');

have_orig = ~isempty(v1) && ~isempty(a1);
have_incr = ~isempty(v2) && ~isempty(a2);

if have_orig || have_incr
    fig = figure('Position', [100 100 880 460], 'Color', 'w');
    if have_orig
        plot(v1*3.6, a1, 'LineWidth', 1.6, 'DisplayName', 'Original aero');
    end
    hold on;
    if have_incr
        plot(v2*3.6, a2, 'LineWidth', 1.6, 'DisplayName', 'Increased aero');
    end
    grid on; box on;
    xlabel('Vehicle speed [km/h]', 'FontSize', 11);
    ylabel('Longitudinal acceleration [m/s^2]', 'FontSize', 11);
    title('Acceleration vs speed — where aero limits performance', 'FontSize', 12);
    legend('Location', 'best');
    set(gca, 'FontSize', 10);
    drawnow;
    exportgraphics(fig, 'fig_aero_accel_vs_speed.png', 'Resolution', 150);
    fprintf('Wrote fig_aero_accel_vs_speed.png\n');
end
