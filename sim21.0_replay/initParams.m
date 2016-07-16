% written by professor Jay McClelland
function [] = initParams(epoch)
% This program initialize and preallocate the parameters needed for the
% model. This should be executed before the simulations.
global p a buffer

%% teaching strategy 
% if teaching style is specified here, then trainGroup will use this 
% value for all models ... 
if ~isfield(p,'teachingStyle')
    p.teachingStyle = 4;
    fprintf('Use the default teaching mode: %d. \n', p.teachingStyle);
else 
    fprintf('Use the input teaching mode: %d. \n', p.teachingStyle);
end

% 1 = final reward only
% 2 = intermediate reward
% 3 = final reward only + teacher forcing
% 4 = intermediate reward + teacher forcing

%% modeling parameters
p.runs = epoch;         % training upper lim
p.maxIter = 100;        % terminate if cannot finish in 100 iter
p.wf = .1;             % noise magnitude
p.sf = .1;              % spread factor -- separating this from noise -- jlm
p.lrate = .0005;        % learning rate
p.gamma = .9;           % discount factor

%% changes over time
a.smgain = 1;           % initial softmax rate
p.smirate = .001;       % softmax decrement rate
p.smi_upperLim = 10;    % upper bound
a.punishFactor = 0.8;   % initial punish factor
p.PFd = .001;           % punish factor decrement rate
p.PF_lowerLim = 0.2;    % lower bound

%% teaching mode
if p.teachingStyle == 3 || p.teachingStyle == 4
    % flag for the teacher forcing mode
    p.teacherForcingOn = 1;
else
    p.teacherForcingOn = 0;
end

%% counting specific
% size of the state space and percetual span
p.spRad = 40;
p.spRange = p.spRad * 2 + 1;
% the max unit that the model can move
p.mvRad = 7;
p.mvRange = p.mvRad * 2 + 1;
p.eyeRad = 15;
p.eyeRange = p.eyeRad * 2 + 1;

% number of items in the environment
p.maxItems = 7;         % max number of items
p.maxSpacing = 5;       % max spacing between neighbouring items
p.minSpacing = 0;       % min spacing between neighbouring items

%% reward values
if p.teachingStyle == 1 || p.teachingStyle == 3
    % less feed back mode
    p.r.smallNeg = 0;
    p.r.midNeg = 0;
    p.r.bigNeg = 0;
    p.r.midPos = 0;
    p.r.bigPos = 10;
elseif p.teachingStyle == 2 || p.teachingStyle == 4
    % with intermediate reward
    p.r.smallNeg = 0;
    p.r.midNeg = 0;
    p.r.midPos = 5;
    p.r.bigPos = 10;
else
    error('Unrecognized teaching mode')
end

%% network specific
% initialize with small small random values
a.wts = zeros(p.mvRange+1, p.eyeRange);
a.bias = 1e-8;     % bias toward not moving (action 0)
p.saveWtsInterval = 100; 


%% experience replay 
p.experienceReply = true;
allReplayMode = {'uniform', 'softmax'};
p.replaySamplingMode = allReplayMode{2};
p.bufferSize = 500;
if ~isfield(p,'replay_batchSize')
    p.replay_batchSize = 5; 
    fprintf('Use the default replay batch size of %d. \n', p.replay_batchSize);
else
    fprintf('Use the input replay batch size of %d. \n', p.replay_batchSize);
end

buffer = struct(...
    's_cur',    repmat({nan}, p.bufferSize, 1), ...
    'a_cur',    repmat({nan}, p.bufferSize, 1), ...
    'a_act',    repmat({nan}, p.bufferSize, 1), ...
    's_next',   repmat({nan}, p.bufferSize, 1), ... 
    'r_cur',    repmat({nan}, p.bufferSize, 1), ...
    'TDErr',    repmat({nan}, p.bufferSize, 1), ...
    'taskDone', repmat({nan}, p.bufferSize, 1));
a.bufferUsage = 0; 
a.usage_startReplay = p.bufferSize; 

end

