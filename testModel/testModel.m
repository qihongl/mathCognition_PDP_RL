%% An little quiz for the model
% this function takes a set of trained weights and parameters, come up with
% a counting question, let the model do the counting, and records its
% performance! So it is in some sense a little quiz for the model.
function [score] = testModel(showPlot, nItem)

global p a w mode;
setTestModeParam();
if nargin == 0
    showPlot = 1;
end
if exist('nItem', 'var')
    mode.fixNumItems = true;
    mode.nItem = nItem;
end

% test the model
% initialization
initState();
updateState();
if showPlot
    initPlot();
    showState();
end

i = 0;
score.indices = zeros(1,p.maxIter);
% test the model
while ~(w.done) && i < p.maxIter
    selectAction();
    move();
    updateState();
    computeRwd();
    updateWeights();
    
    if showPlot
        showState();
    end
    % record the action sequence
    score.indices(i+1) = recordAction();
    i = i+1;
end
if showPlot
    showWeights();
end

score.nItemsShowed = w.nItems;
% record the steps used
score.steps = i;
% check if the model completed the task
if all(w.rS.targRemain == false) && i ~= p.maxIter
    score.completed = true;
else
    score.completed = false;
end
% record errors
score.numSkips = w.numSkips;
score.numDoubleTouch = w.numDoubleTouch;
score.numErrors = w.errors;
end