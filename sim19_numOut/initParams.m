% written by professor Jay McClelland
function [] = initParams(epoch, seed)
% This program initialize and preallocate the parameters needed for the
% model. This should be executed before the simulations. 
global p a

%% modeling parameters 
p.wf = .1;           % noise magnitude
p.lrate = .001;      % learning rate
p.runs = epoch;      % training upper lim 
p.gamma = .9;        % discount factor 
p.smirate = .001;    % soft max incremental rate
p.smi_upperLim = 10; % the upper limit of the smi rate
p.maxIter = 100;     % terminate if cannot finish in 100 iter
p.memory = .5;
p.seed = seed;      


%% teaching mode
% controls the redo mode 
p.teachingModeOn = 0;
p.maxTeachTrial = 100;

% flag for the teacher forcing mode 
p.teacherForcingOn = 0;


%% item specific
% size of the state space and percetual span
p.spRad = 40;
p.spRange = p.spRad * 2 + 1;
% the max unit that the model can move
p.mvRad = 7; 
p.mvRange = p.mvRad * 2 + 1;
p.eyeRad = 15; 
p.eyeRange = p.eyeRad * 2 + 1;

% number of items in the environment
p.maxItems = 5;         % max number of items
p.maxSpacing = 5;       % max spacing between neighbouring items
p.minSpacing = 2;       % min spacing between neighbouring items

%% counting specific
p.maxCount = p.maxItems;  % number of units in the numOut layer 
p.nCountUnits = p.maxCount + 1;

%% reward values
p.r.smallNeg = - 0.05;
p.r.midNeg = - .5;
p.r.bigNeg = - 5;
p.r.midPos = 5;
p.r.bigPos = 10;
% reward policy 2: no intermediate feed back 
% p.r.smallNeg = - 0.05;
% p.r.midNeg = p.r.smallNeg;
% p.r.bigNeg = p.r.smallNeg;
% p.r.midPos = p.r.smallNeg;
% p.r.bigPos = 10;

%% actively stop the task
% if the model doesn't move for N steps, terminate the task
p.stopCounter = 3;

%% network specific
p.nHidden = p.eyeRange+p.nCountUnits; 
a.bias = .1;     % bias toward not moving (action 0)
a.smgain = 1;
% initialize with small small random values 
a.wts_VH = randSmallWeights(p.nHidden, p.eyeRange);     % visual->hidden
a.wts_HA = randSmallWeights(p.mvRange, p.nHidden);      % hidden->action
a.wts_HN = randSmallWeights(p.nCountUnits, p.nHidden);  % hidden->number
a.wts_NH = randSmallWeights(p.nHidden, p.nCountUnits);  % number->hidden

%% insert testing questions during the training
p.testInterval = 100; 
p.testBatchSize = 10; 
end

