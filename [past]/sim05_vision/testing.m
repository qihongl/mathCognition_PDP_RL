%% run the touching model
function out = testing(numtrials)
if nargin == 0
    numtrials = 200;
end

% function [output] = touch(epochs, seed, ...
%     doPlotting, showSteps, showProgress)

out = touch(numtrials, 0, 1, 0, 0);
end