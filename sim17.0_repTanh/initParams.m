% written by professor Jay McClelland
function [] = initParams(epoch)
% This program initialize and preallocate the parameters needed for the
% model. This should be executed before the simulations.
global p a

% p.teachingStyle = 2;
% 1 = final reward only
% 2 = intermediate reward
% 3 = final reward only + teacher forcing
% 4 = intermediate reward + teacher forcing

%% modeling parameters
p.runs = epoch;         % training upper lim
p.maxIter = 100;        % terminate if cannot finish in 100 iter
p.wf = .10;             % noise magnitude
p.lrate = .0001;        % learning rate
p.gamma = .9;           % discount factor
a.smgain = 1;           % initial softmax rate
p.smirate = .001;       % softmax decrement rate
p.smi_upperLim = 10;    % the upper limit of the smi rate

if p.teachingStyle == 1 || p.teachingStyle == 3
    a.punishFactor = 0.8;   % count how many errors the model made
    p.PFd = .001;
elseif p.teachingStyle == 2 || p.teachingStyle == 4
    a.punishFactor = 1;   % count how many errors the model made
    p.PFd = 0;
else
    error('Unrecognized teaching mode')
end
p.PF_lowerLim = 0.2;

%% teaching mode
p.teachingModeOn = 0;
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
p.minSpacing = 2;       % min spacing between neighbouring items

%% reward values
if p.teachingStyle == 1 || p.teachingStyle == 3
    % less feed back mode
    p.r.smallNeg = 0;
    p.r.midNeg = 0;
    p.r.bigNeg = 0;
    p.r.midPos = 0;
    p.r.bigPos = 1;
elseif p.teachingStyle == 2 || p.teachingStyle == 4
    % with intermediate reward
    p.r.smallNeg = -0.05;
    p.r.midNeg = -1;
    p.r.midPos = 5;
    p.r.bigPos = 10;
else
    error('Unrecognized teaching mode');
end

%% network specific
p.nHidden = 31; 
% initialize with small small random values
a.wts_VH = randSmallWeights(p.nHidden, p.eyeRange); 
a.wts_HA = randSmallWeights(p.mvRange, p.nHidden); 
a.bias = 0.1;     % bias toward not moving (action 0)

end

