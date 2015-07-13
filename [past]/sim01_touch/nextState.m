function [ w ] = nextState( w, p )
%NEXTSTATE the trainsition function
% This is a function maps action to the next state

% transit to the target state with probability 1
w.nexts = w.cura;

% give reward
if w.nexts == w.targets
    w.R = 1;
else
    w.R = 0;
end

end

