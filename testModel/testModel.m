%% An little quiz for the model
% this function takes a set of trained weights and parameters, come up with
% a counting question, let the model do the counting, and records its
% performance! So it is in some sense a little quiz for the model.
function [score] = testModel(seed, showPlot)
if nargin == 0
    seed = randi(999);
    showPlot = 1;
end
rng(seed)

global p a w;

%% test the model
% initialization
initState();
updateState();
if showPlot
    initPlot();
    showState();
end
% w.rS    % show the initial state
i = 0;
score.indices = zeros(1,100);
% test the model
while ~(w.done) && i < 100
    selectAction();
    Act();
    updateState();
    updateWeights();
    if showPlot
        showState();
    end
    % record the action sequence 
    score.indices(i+1) = recordAction();
    i = i+1;
end
% record the steps used
score.steps = i;
% check if the model completed the task
if length(nonzeros(score.indices)) == w.nItems && score.steps~=p.maxIter
    score.completed = true;
else 
    score.completed = false;
end

end