% written by professor Jay McClelland
function [ results ] = runAgent(seed)
global a w h p;
rng(seed)
w.seed = seed;

%% initialize the state
initState();
updateState();

%% training the model once 
i = 0;
while ~(w.done) && i < 100
    % alternate action and state update
    selectAction();
    Act();
    updateState();
    updateWeights();
    i = i+1;
    %% teaching mode 
    if p.teach && w.redo
        % re-initialize the world if REDO 
        reinitState();
        updateState();
        i = 0;
    end
end
%% save result
results.steps = i;
results.h = h;
results.a = a;
end