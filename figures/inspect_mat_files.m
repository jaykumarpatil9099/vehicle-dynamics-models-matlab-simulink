%% inspect_mat_files.m
% Prints a full inventory of what's actually inside each .mat file in
% results/data/ — variable names, classes, logged signals, and whether
% they're timeseries / Datasets / structs.
%
% Run this first when the plot scripts come back with empty plots:
%   cd figures
%   inspect_mat_files
%
% Copy the printed output and use it to update the SIGNALS cell arrays at
% the top of plot_aero_comparison.m, plot_vehicle_comparison.m, and the
% SIGNAL_BODY / SIGNAL_WHEEL strings in plot_fft_modes.m.

clear; close all;

data_dir = fullfile('..', 'results', 'data');
files = {'out_original_aero.mat', 'out_increased_aero.mat', ...
         'out_roadcar.mat',       'out_formulacar.mat'};

for i = 1:length(files)
    fname = files{i};
    fprintf('\n============================================================\n');
    fprintf('FILE: %s\n', fname);
    fprintf('============================================================\n');

    loaded = load(fullfile(data_dir, fname));
    saved_vars = fieldnames(loaded);
    fprintf('Top-level variables in the .mat: %s\n', strjoin(saved_vars, ', '));

    for v = 1:numel(saved_vars)
        vn  = saved_vars{v};
        obj = loaded.(vn);
        fprintf('\n  Variable "%s"  (class: %s)\n', vn, class(obj));

        if isa(obj, 'Simulink.SimulationOutput')
            % SimulationOutput exposes saved variables via .who
            try
                names = obj.who;
            catch
                names = fieldnames(obj);
            end
            fprintf('    Saved signals/variables (use these names in SIGNALS{}):\n');
            if isempty(names)
                fprintf('      (none)\n');
            end
            for k = 1:numel(names)
                nm  = names{k};
                try
                    val = obj.(nm);
                catch
                    fprintf('      "%s"  [could not read]\n', nm);
                    continue
                end
                cls = class(val);
                if isa(val, 'timeseries')
                    fprintf('      "%s"  [timeseries, %d samples, %d data cols]\n', ...
                        nm, numel(val.Time), size(val.Data, 2));
                elseif isa(val, 'Simulink.SimulationData.Dataset')
                    n = val.numElements;
                    fprintf('      "%s"  [Dataset with %d element(s)]:\n', nm, n);
                    for kk = 1:n
                        e = val.getElement(kk);
                        ecls = class(e.Values);
                        sz   = '';
                        if isa(e.Values, 'timeseries')
                            sz = sprintf(' (%d samples)', numel(e.Values.Time));
                        end
                        fprintf('          - "%s"  [%s%s]\n', e.Name, ecls, sz);
                    end
                elseif isstruct(val) && isfield(val, 'time') && isfield(val, 'signals')
                    fprintf('      "%s"  [Structure-with-time, %d samples]\n', ...
                        nm, numel(val.time));
                else
                    fprintf('      "%s"  [%s, size=%s]\n', ...
                        nm, cls, mat2str(size(val)));
                end
            end
        elseif isstruct(obj)
            fns = fieldnames(obj);
            fprintf('    Struct fields: %s\n', strjoin(fns, ', '));
        else
            fprintf('    (not a SimulationOutput or struct — class %s)\n', class(obj));
        end
    end
end

fprintf('\n--- Done. Paste this output to me to update the plot scripts. ---\n');
