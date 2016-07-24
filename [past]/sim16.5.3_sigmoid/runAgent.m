% written by professor Jay McClelland
function [ results ] = runAgent()
global a w h p mode;

%% initialize the state
initState();
updateState();
computeAnswer();    % compute the true 'answers'

%% training the model once
i = 0;
indices = zeros(1,p.maxIter);
while ~(w.done) && i < p.maxIter
    %% choose action
    selectAction();
    move();
    %% update the state
    updateState();
    updateWeights();
    indices(i + 1) = recordAction();     % record the "touch-index"
    i = i+1;
end

updateTeachingConditions();

%% save result
results.numErrors = w.errors;
results.indices = indices;
results.steps = i;
results.h = h;
results.a = a;
end


%% Helper functions
function updateTeachingConditions()
global mode w p;
% check if it is behave correctly
if p.teacherForcingOn && mode.teacherForcing
    fprintf('.')
    if w.nItems + 1 ~= w.stateNum
        warning('?')
    end
end
end