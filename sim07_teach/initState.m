% written by professor Jay McClelland
function [ ] = initState( )

global a w d h p;

%realState is characterized by the position of a target to touch,
%position of eye, and position of hand
%in a 101-pixel one-d space

%viewedState is the input I have given that my eye and hand are
%at particular positions w.r.t. the realState of the world
%for now we treat hand position as a single value rather than as a
%distribution over possible values in a map.

%actions consist of moving the eye OR the hand a certain distance

%% specify the parameters
%a.net = zeros(2,1);
a.act = zeros(p.mvRange,1);
a.dfRwd = 0;
a.Rwd = 0;

% real state
w.rS.time = 0;
w.rS.td = 0;
w.stateNum = -1;

% decide the number of items to generate
if p.randItems
    w.nItems = randi(p.nItems);
else
    w.nItems = p.nItems;
end
% generate items in space
w.rS.targPos = itemGen(w.nItems);
w.rS.targRemain = true(w.nItems, 1);
w.done = false;

% initialize the location of hand and eye
w.rS.eyePos = min(w.rS.targPos) - ceil(rand * p.maxSpacing);
w.rS.handPos = min(w.rS.targPos) - ceil(rand * p.maxSpacing);

% view state or the perceived state
w.vS.oldInput = zeros(1,p.spRange);
w.vS.visInput = zeros(1,p.spRange);
w.out.handStep = 0;
w.out.eyeStep = 0;

% save
h = struct('w',w);

% plot
axes(d.hax); cla;
axes(d.rax); cla;
end

