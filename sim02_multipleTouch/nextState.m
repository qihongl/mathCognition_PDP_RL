function [ w ] = nextState(w)
%NEXTSTATE the trainsition function
% This is a function maps action to the next state

% transit to the target state with probability 1
w.nexts = w.cura;

% give the reward for the next state
if w.targetsRemain(w.nexts)
    w.targetsRemain(w.nexts) = false;
    w.R = 0;
    
    % give reward if all items were touched
    if all(w.targetsRemain == false)
        w.R = 2;
        w.done = true;
    end
    
else
    w.R = 0;    % 
end

end

