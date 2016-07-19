% written by professor Jay McClelland
function [ results ] = runAgent()
global a w h p mode;

%% initialize the state
initState();
updateState();
% compute the true answers, for teacher demonstration 
computeAnswer();    

%% train the model once
t = 0;
indices = zeros(1,p.maxIter);
while ~(w.done) && t < p.maxIter
    %% choose action
    selectAction();
    move();
    updateState();
    updateWeights();
    indices(t + 1) = recordAction();     % record the "touch-index"
    t = t+1;
end

updateTeachingConditions();

%% save result
results.numErrors = w.errors;
results.indices = indices;
results.steps = t;
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