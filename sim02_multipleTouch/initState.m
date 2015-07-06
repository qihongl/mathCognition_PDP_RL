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

%% counting specific
% generate a target randomly in the range
w.targets = false(1,p.range);
while sum(w.targets) < p.numItems   % generate items in space
    w.targets(randi(p.range)) = true;
end 

w.targetsRemain = w.targets;    % indicate the progress of the task
w.memory = zeros(1,p.range);    % "working memory"
w.done = false;                 % flag for stop the counting process

end

