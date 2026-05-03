# How to generate the README figures

All four scripts run in MATLAB R2024a. Each one writes one or more `fig_*.png` files into this folder, which the README then references.

## One-time setup

Add the repo's `shared/` folder to your MATLAB path so `get_signal.m` and `fft_VD.m` are reachable:

```matlab
addpath(genpath('shared'))
savepath   % optional, makes it persist
```

## Run each script

```matlab
cd figures

plot_aero_comparison       % overlays original vs increased aero from the .mat files
plot_vehicle_comparison    % overlays road-car vs formula-car runs
plot_pacejka_curves        % analytical front vs rear Pacejka + load family (no .mat needed)
plot_fft_modes             % uses fft_VD.m to spectrum a logged signal — body modes + wheel-hop
```

Each script creates `.png` files alongside itself (in `figures/`).

## If a plot comes out empty

The `out_*.mat` files contain `Simulink.SimulationOutput` objects. The plotting scripts try three common locations to find each signal: `logsout`, `yout`, and direct dot-field access. If none of those match the names used in your model, the script warns and skips that plot.

To find the actual signal names used in your model:

```matlab
out = load('../results/data/out_original_aero.mat');
out = out.out;
out.logsout                  % shows the signal-logging dataset
% or
out.yout
% or
fieldnames(out)              % shows direct fields (To-Workspace blocks)
```

Then update the `SIGNALS` cell array at the top of the relevant plot script with the matching names. Same edit pattern in `plot_aero_comparison.m` and `plot_vehicle_comparison.m`; rename `SIGNAL_BODY` / `SIGNAL_WHEEL` strings in `plot_fft_modes.m`.

## Plots referenced in the README

| Plot | Script | Notes |
|---|---|---|
| Aero balance: pitch / roll / yaw rate over time | `plot_aero_comparison.m` | Generates one PNG per signal in `SIGNALS` |
| Road car vs formula car responses | `plot_vehicle_comparison.m` | Generates one PNG per signal in `SIGNALS` |
| Pacejka curves — front vs rear axle | `plot_pacejka_curves.m` | Analytical, no .mat needed |
| Pacejka load sensitivity (front axle, 4 loads) | `plot_pacejka_curves.m` | Same script, second figure |
| Body-mode FFT | `plot_fft_modes.m` | Uses `fft_VD.m` from `shared/` |
| Wheel-hop FFT | `plot_fft_modes.m` | Same script, second figure |

Pick whichever subset you want to feature in the README — 4-6 plots is the usual sweet spot.
