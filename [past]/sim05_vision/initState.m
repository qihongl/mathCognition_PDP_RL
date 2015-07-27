% INITSTATE initialize the state parameters, or set up the "world"
% note that all things here are TRIAL SPECIFIC
% originally written by Professor Jay McClelland
function [w] = initState()
global p;
% preallocation 
w.curs = 0;     % current state
% w.cura = 0;     % current action 
w.nexts = 0;    % next state
% w.nexta = 0;    % next action 
w.R = 0;        % reward
w.steps = 0;    % steps used

%% items specific
% specifiy the number of items in the world
% w.numItems = p.numItems;
w.numItems = randi(p.range);    % specifiy the number of items 
w.rS.targets = false(1,p.range);    % preallocate
w.rS.targets(randperm(p.range, w.numItems)) = true; % generate items

w.rS.targetsRemain = w.rS.targets;    % indicate the progress of the task
w.done = false;                 % flag - stopping the counting process

%% vision specific 
% TODO try initialize at randomly location 
% w.rS.s_eyeCur = p.vRad + 1;  % initialize to the left end
w.rS.s_eyeCur = 0;
w.rS.s_eyeNext = 0;
% randomly initialize the hand position within the perceptual span
w.rS.s_handCur = datasample(p.vSpan,1);
w.rS.s_handCur = 0;
w.rS.s_handNext = 0;
w.rS.a_eyeCur = 0;
w.rS.a_eyeNext = 0;
w.rS.a_handCur = 0;
w.rS.a_handNext = 0;

% get the perceived states
w.vS.targets = w.rS.targets(p.vSpan);

% initialize perceived eye & hand positions
w.vS.eye = 0;
w.vS.handCur = w.rS.s_handCur - w.rS.s_eyeCur;
w.vS.handNext = 0;

%% teaching mode controller 
if p.teachTrial > 0 
    w.teach = true;
    p.teachTrial = p.teachTrial - 1;
    w.truth = 1:p.range;    % set the right answer 
else 
    w.teach = false; 
end 

end

