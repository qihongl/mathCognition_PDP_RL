% written by professor Jay McClelland
function [ results ] = runAgent()
global a w h p;

%% initialize the state
initState();
updateState();
w.answer = computeAnswer(w);    % compute the true answers

%% training the model once
i = 0;
indices = zeros(1,p.maxIter);
while ~(w.done) && i < p.maxIter
    %% choose action 
    selectAction();
    Act();
    %% update the state
    updateState();
    updateWeights();
    indices(i + 1) = recordAction();     % record the "touch-index"
    i = i+1;
    %% teaching mode, executed when redo is needed
    if p.teachingModeOn && p.teach && w.redo
        fprintf('.');
        % re-initialize the world if REDO
        reinitState();  i = 0;
        updateState();
        w.maxTeachTrial = w.maxTeachTrial - 1;  % decrement teacher's patience
        if w.maxTeachTrial == 0 
            p.teach = false;
        end
    end
end
if p.teachingModeOn
    p.teach = 1;
end
% check if it is behave correctly
if p.teacherForcing
    if w.nItems + 1 ~= w.stateNum
        warning('?')
    end
end


%% save result
results.indices = indices;
results.steps = i;
results.h = h;
results.a = a;
end