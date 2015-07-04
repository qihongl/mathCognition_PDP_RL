function [ w ] = nextState( w, p )
%NEXTSTATE the trainsition function
% This is a function maps action to the next state

% transit to the target state with probability 1
w.nexts = w.cura;

% give reward
if sum(w.spotsTouched(w.targets) & w.targets(w.targets)) == p.numItems
    w.R = 1;
    w.done = true; 
elseif w.targets(w.nexts) == true
    w.R = 0.1;
else
    w.R = 0;
end

end

