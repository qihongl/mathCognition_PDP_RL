function [] = reinitState()
% Initialize the current state to the initial state
% It is used in a teaching mode, where the "teacher" let the agent do the
% same task again when the agent made a mistake. 
global a h w p;

%% specify the parameters
a.act = zeros(p.mvRange,1);
a.dfRwd = 0;
a.Rwd = 0;

% real state
w.rS.time = 0;
w.rS.td = 0;
w.stateNum = -1;

% place the item in space like the beginning 
w.rS.targPos = h(1).w.rS.targPos;
w.rS.targRemain = true(w.nItems, 1);
w.done = false;
w.redo = false;

% re-initialize the location of hand and eye
w.rS.eyePos = h(1).w.rS.eyePos;
w.rS.handPos = h(1).w.rS.handPos;

% view state or the perceived state
w.vS.oldInput = zeros(1,p.spRange);
w.vS.visInput = zeros(1,p.spRange);
w.out.handStep = 0;
w.out.eyeStep = 0;

% save
h = struct('w',w);

end

