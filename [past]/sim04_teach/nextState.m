function [ w ] = nextState(w)
%NEXTSTATE the trainsition function
% This is a function maps action to the next state
global p;
% transit to the target state with probability 1
w.nexts = w.cura;

% give the reward for the next state
if w.targetsRemain(w.nexts)
    w.targetsRemain(w.nexts) = false;
    w.R = p.subR;
    
    % give bonus reward if ALL items were touched
    if all(w.targetsRemain == false)
        w.R = p.finalR;
        w.done = true;
    end
    
else
    w.R = p.punish;    % 
end

end

