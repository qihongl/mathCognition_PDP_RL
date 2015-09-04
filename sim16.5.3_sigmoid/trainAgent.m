%% Trains the network n trials
% written by professor Jay McClelland
function [record] = trainAgent(epoch, seed)
%% initialization
% initialize parameters
global p a w mode;
initParams(epoch);
p.seed = seed;
rng(seed)

% preallocate
record.a = cell(1,epoch);
s.steps = nan(1,epoch);
s.indices = cell(1,epoch);
s.completed = false(1,epoch);
s.numItemsShowed = zeros(1,epoch);

% train the model for n trials
fprintf('%s\n', pwd);
fprintf('Start training for %d epochs\n', epoch);
for i = 1:p.runs
    fprintf('%d\n', i )
    %% alternate between forcing and self exp (iff forcing mode is on)
    if p.teacherForcingOn == true;
        mode.teacherForcing = false;
        if mod(i,2) == 0
            mode.teacherForcing = true;
        end
    end
    %% run the model
    result = runAgent();
    % increment the softmax scaling factor
    updateSmiPf();
    %% save performance
    s.numErrors(i) = result.numErrors;
    s.steps(i) = result.steps;
    s.indices{i} = result.indices;
    s.numItemsShowed(i) = w.nItems;
    if all(w.rS.targRemain==false) && i ~= p.maxIter
        s.completed(i) = true;
    end
end
% save parameters
record.p = p;
record.a = result.a;
record.s = s;
end


function [] = updateSmiPf()

global a p ;
% update softmax rate
if a.smgain < p.smi_upperLim
    a.smgain = a.smgain + p.smirate;
end

% update punish factor
if a.punishFactor > p.PF_lowerLim
    a.punishFactor = a.punishFactor - p.PFd;
end

end

