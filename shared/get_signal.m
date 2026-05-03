function [t, y] = get_signal(simout, name)
%GET_SIGNAL  Robustly extract a logged signal from a Simulink simulation output.
%
%   [t, y] = GET_SIGNAL(simout, name) tries the common Simulink logging
%   locations in order: logsout dataset → yout dataset → direct dot-field
%   access (timeseries or To-Workspace struct). Returns time and data
%   vectors, or empties + warning if not found.
%
%   Use inside the figures/ plotting scripts so the same script works
%   regardless of whether you used signal logging, root output ports, or
%   To-Workspace blocks.
%
%   Example:
%       out = load('out_original_aero.mat');
%       [t, pitch] = get_signal(out.out, 'pitch_angle');
%       plot(t, rad2deg(pitch));

    t = []; y = [];

    % 1. Signal-logging dataset (most common in modern Simulink)
    try
        elem = simout.logsout.getElement(name);
        t = elem.Values.Time;
        y = squeeze(elem.Values.Data);
        return
    catch
    end

    % 2. Root output dataset (for models with output ports)
    try
        elem = simout.yout.getElement(name);
        t = elem.Values.Time;
        y = squeeze(elem.Values.Data);
        return
    catch
    end

    % 3. Direct dot-field access (To-Workspace block, "Structure with time")
    try
        s = simout.(name);
        if isa(s, 'timeseries')
            t = s.Time;
            y = squeeze(s.Data);
            return
        elseif isstruct(s) && isfield(s, 'time') && isfield(s, 'signals')
            t = s.time;
            y = squeeze(s.signals.values);
            return
        end
    catch
    end

    warning('get_signal:NotFound', ...
        'Could not find signal "%s" in simulation output. Check the name in your model.', name);
end
