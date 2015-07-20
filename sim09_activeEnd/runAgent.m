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
teachTrial = 0;
indices = zeros(1,p.maxIter);
while ~(w.done) && i < p.maxIter
    % alternate action and state update
    selectAction();
    Act();
    updateState();
    updateWeights();
    
    indices(i + 1) = recordAction();     % record the "touch-index"
    
    i = i+1;
    %% teaching mode
    if p.teachingModeOn && p.teach && w.redo
        fprintf('.');
        % re-initialize the world if REDO
        reinitState();
        updateState();
        i = 0;
        teachTrial = teachTrial + 1;
        if teachTrial > p.maxTeachTrial
            % teacher give up if the model don't learn in 100 iterations
            p.teach = 0;
        end
    end
end
if p.teachingModeOn
    p.teach = 1;
end

%% save result
results.indices = indices;
results.steps = i;
results.h = h;
results.a = a;


end