%% plot_vehicle_comparison.m
% Overlays the road-car parameter set vs the formula-class parameter set
% under matched inputs. Handling-domain comparison.
% Reads:  ../results/data/out_roadcar.mat
%         ../results/data/out_formulacar.mat
% Writes: ./fig_vehicle_*.png
%
% Run:
%   cd figures
%   addpath(genpath('../shared'))
%   plot_vehicle_comparison

clear; close all;
addpath('../shared');

%% Load
road = load('../results/data/out_roadcar.mat');
form = load('../results/data/out_formulacar.mat');
road = road.out;
form = form.out;

%% Time-history signals to compare (handling domain)
% Logged in the model via To-Workspace blocks. SWA, sideslip, yawrate are
% in radians and rad/s — converted to degrees for readability.
SIGNALS = {
    'SWA',       'Steering wheel angle [deg]', 180/pi;
    'latacc',    'Lateral acceleration [m/s^2]', 1.0;
    'sideslip',  'Side-slip angle [deg]',      180/pi;
    'yawrate',   'Yaw rate [deg/s]',           180/pi;
};

for k = 1:size(SIGNALS, 1)
    name  = SIGNALS{k, 1};
    label = SIGNALS{k, 2};
    scale = SIGNALS{k, 3};

    [t1, y1] = get_signal(road, name);
    [t2, y2] = get_signal(form, name);
    if isempty(y1) && isempty(y2), continue, end

    fig = figure('Position', [100 100 880 460], 'Color', 'w');
    if ~isempty(y1)
        plot(t1, y1*scale, 'LineWidth', 1.6, 'DisplayName', 'Road car');
    end
    hold on;
    if ~isempty(y2)
        plot(t2, y2*scale, 'LineWidth', 1.6, 'DisplayName', 'Formula car');
    end
    grid on; box on;
    xlabel('Time [s]', 'FontSize', 11);
    ylabel(label, 'FontSize', 11);
    title(sprintf('Vehicle comparison — %s', label), 'FontSize', 12);
    legend('Location', 'best');
    set(gca, 'FontSize', 10);
    drawnow;

    out_png = sprintf('fig_vehicle_%s.png', name);
    exportgraphics(fig, out_png, 'Resolution', 150);
    fprintf('Wrote %s\n', out_png);
end

%% Bonus: X-Y trajectory comparison
[~, x1] = get_signal(road, 'X');
[~, y1] = get_signal(road, 'Y');
[~, x2] = get_signal(form, 'X');
[~, y2] = get_signal(form, 'Y');

have_road = ~isempty(x1) && ~isempty(y1);
have_form = ~isempty(x2) && ~isempty(y2);

if have_road || have_form
    fig = figure('Position', [100 100 720 720], 'Color', 'w');
    if have_road
        plot(x1, y1, 'LineWidth', 1.6, 'DisplayName', 'Road car');
    end
    hold on;
    if have_form
        plot(x2, y2, 'LineWidth', 1.6, 'DisplayName', 'Formula car');
    end
    grid on; box on; axis equal;
    xlabel('X [m]', 'FontSize', 11);
    ylabel('Y [m]', 'FontSize', 11);
    title('Vehicle trajectory — road car vs formula car', 'FontSize', 12);
    legend('Location', 'best');
    set(gca, 'FontSize', 10);
    drawnow;
    exportgraphics(fig, 'fig_vehicle_trajectory.png', 'Resolution', 150);
    fprintf('Wrote fig_vehicle_trajectory.png\n');
end
