%% inspect_aero_files.m
% Focused inspection of just the two aero .mat files. Captures the output
% to inspect_output.txt so it survives the Command Window scrollback limit.
%
% Run:
%   cd figures
%   inspect_aero_files
%
% After running, the file inspect_output.txt appears next to this script.

if exist('inspect_output.txt', 'file'), delete('inspect_output.txt'); end
diary('inspect_output.txt');
diary on;

data_dir = fullfile('..', 'results', 'data');
files = {'out_original_aero.mat', 'out_increased_aero.mat'};

for i = 1:numel(files)
    fname = files{i};
    fprintf('\n============================================================\n');
    fprintf('FILE: %s\n', fname);
    fprintf('============================================================\n');

    loaded     = load(fullfile(data_dir, fname));
    saved_vars = fieldnames(loaded);
    fprintf('Top-level variables in the .mat: %s\n', strjoin(saved_vars, ', '));

    for v = 1:numel(saved_vars)
        vn  = saved_vars{v};
        obj = loaded.(vn);
        fprintf('\n  Variable "%s"  (class: %s)\n', vn, class(obj));

        if isa(obj, 'Simulink.SimulationOutput')
            try
                names = obj.who;
            catch
                names = fieldnames(obj);
            end
            fprintf('    Saved signals/variables:\n');
            if isempty(names), fprintf('      (none)\n'); end
            for k = 1:numel(names)
                nm = names{k};
                try
                    val = obj.(nm);
                    cls = class(val);
                    if isa(val, 'timeseries')
                        fprintf('      "%s"  [timeseries, %d samples, %d data cols]\n', ...
                            nm, numel(val.Time), size(val.Data, 2));
                    elseif isa(val, 'Simulink.SimulationData.Dataset')
                        fprintf('      "%s"  [Dataset with %d element(s)]:\n', nm, val.numElements);
                        for kk = 1:val.numElements
                            e = val.getElement(kk);
                            fprintf('          - "%s"  [%s]\n', e.Name, class(e.Values));
                        end
                    elseif isstruct(val) && isfield(val, 'time') && isfield(val, 'signals')
                        fprintf('      "%s"  [Structure-with-time, %d samples]\n', ...
                            nm, numel(val.time));
                    else
                        fprintf('      "%s"  [%s, size=%s]\n', ...
                            nm, cls, mat2str(size(val)));
                    end
                catch ME
                    fprintf('      "%s"  ERROR: %s\n', nm, ME.message);
                end
            end
        else
            fprintf('    (not a SimulationOutput, class %s)\n', class(obj));
        end
    end
end

diary off;
fprintf('\nDone. Output also saved to: %s\n', fullfile(pwd, 'inspect_output.txt'));
