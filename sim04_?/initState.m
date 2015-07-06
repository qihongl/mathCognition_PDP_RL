% INITSTATE initialize the state parameters, or set up the "world"
% note that all things here are TRIAL SPECIFIC
% originally written by Professor Jay McClelland
function [w] = initState(p)
% preallocation 
w.curs = 0;     % current state
w.cura = 0;     % current action 
w.nexts = 0;    % next state
w.nexta = 0;    % next action 

w.R = 0;        % reward
w.steps = 0;    % steps used

%% counting specific
% specifiy the number of items in the world
w.numItems = randi(p.range);
% w.numItems = p.numItems;

% generate a target randomly in the range
w.targets = false(1,p.range);
while sum(w.targets) < w.numItems   % generate items in space
    w.targets(randi(p.range)) = true;
end 

w.targetsRemain = w.targets;    % indicate the progress of the task
w.done = false;                 % flag - stopping the counting process

%% implement vision and memory
w.memory = zeros(1,p.range);    % "working memory"
w.vision = w.targets;           % what the model sees
end

