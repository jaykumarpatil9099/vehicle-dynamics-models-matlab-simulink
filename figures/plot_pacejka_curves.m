%% plot_pacejka_curves.m
% Plots the Pacejka Magic Formula tyre curves analytically using the
% per-axle coefficients from the 14-DoF model parameter set. No simulation
% data needed.
% Writes: ../figures/fig_pacejka_lateral_axle_comparison.png
%         ../figures/fig_pacejka_front_load_family.png
%
% Magic Formula (simplified, lateral form used in the toolkit):
%   Fy = D * sin( C * atan( B * alpha - E * (B * alpha - atan(B * alpha)) ) )
% with peak value:
%   D = (a1 * Fz + a2) * Fz
%
% Run:
%   cd figures
%   plot_pacejka_curves

clear; close all;

%% Load 14-DoF parameter set (provides Bf/Cf/Ef + Br/Cr/Er + a1f/a2f + a1r/a2r)
addpath('../05_dof14_full_vehicle');
Complete_vehicle_simulation_dof14_model_parameters;

%% Slip-angle sweep
alpha_deg = -15:0.1:15;
alpha     = deg2rad(alpha_deg);

%% Vertical loads to evaluate the family at
Fz_set = [1500 3000 4500 6000];   % N — adjust to your operating window

%% Helper
mf_lateral = @(alpha, B, C, E, D) ...
    D .* sin(C .* atan(B .* alpha - E .* (B .* alpha - atan(B .* alpha))));

%% ---------- Front vs rear curves at one representative load ----------
Fz_ref = 4000;   % N
Df_ref = (a1f * Fz_ref + a2f) * Fz_ref;
Dr_ref = (a1r * Fz_ref + a2r) * Fz_ref;

Fy_f = mf_lateral(alpha, Bf, Cf, Ef, Df_ref);
Fy_r = mf_lateral(alpha, Br, Cr, Er, Dr_ref);

fig1 = figure('Position', [100 100 900 520], 'Color', 'w');
plot(alpha_deg, Fy_f, 'LineWidth', 1.8, ...
    'DisplayName', sprintf('Front axle (B=%.4f, C=%.4f, E=%.4f)', Bf, Cf, Ef));
hold on;
plot(alpha_deg, Fy_r, 'LineWidth', 1.8, ...
    'DisplayName', sprintf('Rear axle (B=%.4f, C=%.4f, E=%.4f)', Br, Cr, Er));
grid on; box on;
xlabel('Slip angle \alpha [deg]', 'FontSize', 11);
ylabel('Lateral force F_y [N]', 'FontSize', 11);
title(sprintf('Pacejka Magic Formula — front vs rear axle (F_z = %d N)', Fz_ref), 'FontSize', 12);
legend('Location', 'best');
set(gca, 'FontSize', 10);
drawnow;
exportgraphics(fig1, 'fig_pacejka_lateral_axle_comparison.png', 'Resolution', 150);
fprintf('Wrote fig_pacejka_lateral_axle_comparison.png\n');

%% ---------- Front-axle family at varying loads (load sensitivity) ----------
fig2 = figure('Position', [100 100 900 520], 'Color', 'w');
hold on;
for Fz = Fz_set
    D  = (a1f * Fz + a2f) * Fz;
    Fy = mf_lateral(alpha, Bf, Cf, Ef, D);
    plot(alpha_deg, Fy, 'LineWidth', 1.4, ...
        'DisplayName', sprintf('F_z = %d N', Fz));
end
grid on; box on;
xlabel('Slip angle \alpha [deg]', 'FontSize', 11);
ylabel('Lateral force F_y [N]', 'FontSize', 11);
title('Front-axle Pacejka curve — load sensitivity', 'FontSize', 12);
legend('Location', 'best');
set(gca, 'FontSize', 10);
drawnow;
exportgraphics(fig2, 'fig_pacejka_front_load_family.png', 'Resolution', 150);
fprintf('Wrote fig_pacejka_front_load_family.png\n');
