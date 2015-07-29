% written by professor Jay McClelland
function [record] = trainAgent(epoch)
%% This function trains the network n trials
% initialize parameters
global p a w;
initParams(epoch);

% preallocate
record.a = cell(1,epoch);
record.s.steps = nan(1,epoch);
record.s.indices = cell(1,epoch);
record.s.completed = false(1,epoch);
record.s.numItemsShowed = zeros(1,epoch);

% train the model for n trials
fprintf('%s\n', pwd);
fprintf('Start training for %d epochs\n', epoch);
for i = 1:p.runs
    fprintf('%d\n', i )
    % alternate between forcing and self exp
%     if mod(i,2) == 0 
%         p.teacherForcing = true; 
%     else 
%         p.teacherForcing = false; 
%     end
    %% run the model 
    result = runAgent();
    % increment the softmax scaling factor
    if a.smgain < p.smi_upperLim
        a.smgain = a.smgain + p.smirate;
    end
    % save performance
    record.s.steps(i) = result.steps;
    record.s.indices{i} = result.indices;
    record.s.numItemsShowed(i) = w.nItems;
    if w.nItems == length(getNonzeros(record.s.indices{i}))
        record.s.completed(i) = true;
    end
end
% save parameters
record.a = result.a;
record.p = p;
end