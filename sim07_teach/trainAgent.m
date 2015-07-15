% written by professor Jay McClelland
function [record] = trainAgent(epoch)
%% This function trains the network n trials
% initialize parameters
global p d a;
initParamsEtc(epoch);
initPlot();

% preallocate
record.a = cell(1,epoch);
record.steps = nan(1,epoch);
% train the model for n trials
for i = 1:p.runs
    fprintf('%d\n',i);
    result = runAgent(i);
    a.smgain = a.smgain + p.smirate;
    % save weights
    record.a{i} = result.a;
    record.steps(i) = result.steps;
end
% save parameters
record.p = p;
end