% written by professor Jay McClelland
function [record] = trainAgent(epoch)
%% This function trains the network n trials
% initialize parameters
global p d a;
initParams(epoch);
initPlot();

% preallocate
record.a = cell(1,epoch);
record.steps = nan(1,epoch);
% record.indices = cell(1,epoch);
% record.completed = false(1,epoch);
% train the model for n trials
for i = 1:p.runs
    fprintf('%d\n',i);
    %% run the model 
    result = runAgent();
    % increment the softmax scaling factor
    if a.smgain < 10
        a.smgain = a.smgain + p.smirate;
    end
    % save performance
    record.steps(i) = result.steps;
%     record.indices{i} = result.indices;
%     if w.nItems == length(getOrder(record.indices{i}))
%         record.completed(i) = true;
%     end
end
% save parameters
record.a = result.a;
record.p = p;
end