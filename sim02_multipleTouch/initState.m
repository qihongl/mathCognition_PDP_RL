% INITSTATE initialize the state parameters, or set up the "world"
% written by Professor Jay McClelland
function [w] = initState(p)
% preallocation 
w.curs = 0;     % current state
w.cura = 0;     % current action 
w.nexts = 0;    % next state
w.nexta = 0;    % next action 

w.R = 0;        % reward
w.steps = 0;    % steps used
w.done = false;

% generate a target randomly in the range
w.spotsTouched = false(1,p.range);
w.targets = false(1,p.range);
while sum(w.targets) < p.numItems
    w.targets(randi(p.range)) = true;
end 

end

