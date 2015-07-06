function [ w ] = nextState(w,p)
%NEXTSTATE the trainsition function
% This is a function maps action to the next state

% transit to the target state with probability 1
w.nexts = w.cura;

% give the reward for the next state
if w.targetsRemain(w.nexts)
    w.targetsRemain(w.nexts) = false;
    w.R = p.subR;
    
    % give reward if all items were touched
    if all(w.targetsRemain == false)
        w.R = p.finalR;
        w.done = true;
    end
    
else
    w.R = p.punish;    % 
end

end

