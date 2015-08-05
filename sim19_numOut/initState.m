% written by professor Jay McClelland
function [ ] = initState( )
global a w h p mode;

%% initialize the parameters
a.dfRwd = 0;
a.Rwd = 0;
w.rS.time = 0;
w.rS.td = 0;
w.stateNum = -1;

% preallocation - input and activation values for all layers
a.aIn = zeros(p.mvRange,1);             % action layer
a.aAct = zeros(p.mvRange,1);
a.hIn = zeros(p.nHidden,1);             % hidden layer 
a.hAct = zeros(p.nHidden,1);
a.nOutIn = zeros(p.nCountUnits,1);      % number output layer
a.nOutAct = zeros(p.nCountUnits,1);    
a.nPrevIn = zeros(p.nCountUnits,1);     % number context layer - Jordan
a.nPrevAct = zeros(p.nCountUnits,1);    

%% generate items in space
if isfield(mode, 'fixNumItems') && mode.fixNumItems
    w.nItems = mode.nItem;              % fix the number of items
else
    w.nItems = generateNum(p.maxItems);     % sample the number from prob 
end
w.rS.targPos = itemGen(w.nItems);       % generate items
w.rS.targRemain = true(w.nItems, 1);    % set up flag
w.done = false;

%% initialize the location of hand and eye
w.rS.eyePos  = min(w.rS.targPos) - randi(p.maxSpacing);
w.rS.handPos = min(w.rS.targPos) - randi(p.maxSpacing);

% view state or the perceived state
w.vS.oldInput = zeros(1, p.eyeRange);
w.vS.visInput = zeros(1, p.eyeRange);
w.out.handStep = 0;
w.out.eyeStep = 0;

%% counting specific
w.curCorrectNum = 0; 
% w.finalCorrectNum = w.nItems;

%% teaching 
% tryAgain mode specific
w.tryAgain = false;
w.maxTeachTrial = p.maxTeachTrial;
mode.teach = true;

% teacher forcing mode specific
if p.teacherForcingOn
    w.teacherForcing = mode.teacherForcing;
else
    w.teacherForcing = false;
end

%% others
% copy the stop counter value
w.stopCounter = p.stopCounter;

%% save the state 
h = struct('w',w);
end

