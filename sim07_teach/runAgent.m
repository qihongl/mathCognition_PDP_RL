% written by professor Jay McClelland

function [ results ] = runAgent(showPlot)
global a w h p;
if nargin == 0
    showPlot = false;
end

% initialize the state 
initState();
updateState();
if showPlot
    showState();
end
i = 0;
while ~(w.done) && i < 100
    % alternate action and state update 
    selectAction();
    Act();
    updateState();
    updateWeights();
    if showPlot
        showState();
    end
    i = i+1;
end
%keyboard;
results.h = h;
results.a = a;
end
