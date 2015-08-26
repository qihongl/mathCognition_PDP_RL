% written by professor Jay McClelland
function [ ] = initState( )

global a w h p mode;

%realState is characterized by the position of a target to touch,
%position of eye, and position of hand 1-d space

%viewedState is the input I have given that my eye and hand are
%at particular positions w.r.t. the realState of the world
%for now we treat hand position as a single value rather than as a
%distribution over possible values in a map.

%% specify the parameters
a.act = zeros(p.mvRange+1,1);
a.dfRwd = 0;
a.Rwd = 0;
w.rS.time = 0;
w.rS.td = 0;
w.stateNum = -1;

% record errors
w.errors = 0; 
w.numSkips = 0;
w.numDoubleTouch = 0; 
w.stopEarly = false; 

% generate items in space
if isfield(mode, 'fixNumItems') && mode.fixNumItems
    w.nItems = mode.nItem;              % fix the number of items
else
    w.nItems = generateNum(p.maxItems);     % sample the number from prob 
end
w.rS.targPos = itemGen(w.nItems);       % generate items
w.rS.targRemain = true(w.nItems, 1);    % set up flag 
w.done = false;

% initialize the location of hand and eye
w.rS.eyePos  = min(w.rS.targPos) - randi(p.maxSpacing);
w.rS.handPos = min(w.rS.targPos) - randi(p.maxSpacing);

% view state or the perceived state
w.vS.oldInput = zeros(1, p.eyeRange);
w.vS.visInput = zeros(1, p.eyeRange);
w.out.handStep = 0;
w.out.eyeStep = 0;

% teaching specific
w.maxTeachTrial = p.maxTeachTrial;
mode.teach = true; 
if p.teacherForcingOn
    w.teacherForcing = mode.teacherForcing; 
else 
    w.teacherForcing = false; 
end
% save
h = struct('w',w);
end

