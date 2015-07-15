% written by professor Jay McClelland
function [record] = trainAgent(epoch)
%% This function trains the network n trials
% initialize parameters
global p d a;
initParamsEtc(epoch);
initPlot();

% preallocate
record.r = cell(1,epoch);
% result = struct('results',[]);
% train the model for n trials
for i = 1:p.runs
    fprintf('%d\n',i);
    result = runAgent(i);
    a.smgain = a.smgain + p.smirate;
    record.a{i} = result.a;
end

% save the results
% record.final = result.h;
record.p = p;
end