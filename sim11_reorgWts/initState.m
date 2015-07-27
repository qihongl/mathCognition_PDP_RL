% written by professor Jay McClelland
function [ ] = initState( )

global a w h p;

%realState is characterized by the position of a target to touch,
%position of eye, and position of hand
%in a 101-pixel one-d space

%viewedState is the input I have given that my eye and hand are
%at particular positions w.r.t. the realState of the world
%for now we treat hand position as a single value rather than as a
%distribution over possible values in a map.

%actions consist of moving the eye OR the hand a certain distance

%% specify the parameters
a.act = zeros(p.mvRange,1);
a.dfRwd = 0;
a.Rwd = 0;

% real state
w.rS.time = 0;
w.rS.td = 0;
w.stateNum = -1;

% decide the number of items to generate
w.nItems = generateNum(p.maxItems);

% generate items in space
w.rS.targPos = itemGen(w.nItems);
w.rS.targRemain = true(w.nItems, 1);
w.done = false;

% teaching specific
w.redo = false;

% initialize the location of hand and eye
% left
w.rS.eyePos  = min(w.rS.targPos) - randi(p.maxSpacing);
w.rS.handPos = min(w.rS.targPos) - randi(p.maxSpacing);

% view state or the perceived state
w.vS.oldInput = zeros(1,p.mvRange);
w.vS.visInput = zeros(1,p.mvRange);
w.out.handStep = 0;
w.out.eyeStep = 0;

%
w.stopCounter = p.stopCounter;

% save
h = struct('w',w);
end

