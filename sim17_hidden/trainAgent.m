%% Trains the network n trials
% written by professor Jay McClelland
function [record] = trainAgent(epoch, seed)
%% initialization
% initialize parameters
rng(seed)
global p a w mode;
initParams(epoch);

% preallocate
record.a = cell(1,epoch);
s.steps = nan(1,epoch);
s.indices = cell(1,epoch);
s.completed = false(1,epoch);
s.numItemsShowed = zeros(1,epoch);
testScores = cell(1, epoch/p.testInterval);

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
    if a.smgain < p.smi_upperLim
        a.smgain = a.smgain + p.smirate;
    end
    %% save performance
    s.numErrors(i) = result.numErrors;
    s.steps(i) = result.steps;
    s.indices{i} = result.indices;
    s.numItemsShowed(i) = w.nItems;
    if w.nItems == length(getNonzeros(s.indices{i}))
        s.completed(i) = true;
    end
    %% get test score for the model 
%     if mod(i-1, p.testInterval) == 0
%         % save the parameters
%         temp.p = p; temp.a = a; temp.w = w; temp.mode = mode;
%         testScores{((i-1)/ p.testInterval) +1} = insertTesting();
%         p = temp.p; a = temp.a; w = temp.w; mode = temp.mode;
%     end
    
end
% save parameters and performance
record.p = p;
record.a = result.a;
record.s = s;
record.testScores = testScores;
end