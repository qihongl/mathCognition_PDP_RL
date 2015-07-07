% INITSTATE initialize the state parameters, or set up the "world"
% note that all things here are TRIAL SPECIFIC
% originally written by Professor Jay McClelland
function [w] = initState(p)
%% preallocation for general varibles
w.curs = 0;     % current state
w.cura = 0;     % current action 
w.nexts = 0;    % next state
w.nexta = 0;    % next action 
w.R = 0;        % reward
w.steps = 0;    % steps used

%% counting specific
% generate items randomly
w.numItems = randi(p.range);    % specifiy the number of items 
w.rS.targets = false(1,p.range);    % preallocate
w.rS.targets(randperm(p.range, w.numItems)) = true; % generate items
w.targetsRemain = w.rS.targets;    % indicate the progress of the task
w.done = false;                 % flag - stopping the counting process

%% vision specific 
% TODO try initialize at randomly location 
w.rS.eyePos = p.visualRadius + 1;  % initialize to the left end
% generate a symertic perceptual span
visualSpan = (w.rS.eyePos-p.visualRadius) : (w.rS.eyePos+p.visualRadius);
% randomly initialize the hand position within the perceptual span
w.rS.handPos = datasample(visualSpan,1);
% get the perceived space
w.vS.targets = w.rS.targets(visualSpan);
% initialize perceived eye & hand positions
w.vS.eyePos = 0;
w.vS.handPos = w.rS.handPos - w.rS.eyePos;

end

