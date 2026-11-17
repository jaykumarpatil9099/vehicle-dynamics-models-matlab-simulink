function plan = buildfile
%BUILDFILE  MATLAB build plan (R2023b+).
%   buildtool            -> static code analysis + smoke tests (models load, params run)
%   buildtool figures    -> regenerate the README figures (needs results/data/*.mat)
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

plan = buildplan(localfunctions);

plan("check") = CodeIssuesTask(["shared", "figures", "tests"]);
plan("test")  = TestTask("tests");

plan.DefaultTasks = ["check", "test"];
end

function figuresTask(~)
% Regenerate the README figures
here = pwd;
cleanup = onCleanup(@() cd(here));
cd(fullfile(fileparts(mfilename("fullpath")), "figures"));
for s = ["plot_pacejka_curves", "plot_aero_comparison", "plot_vehicle_comparison", "plot_fft_modes"]
    run(s);
    close all;
end
end
