% written by professor Jay McClelland
function [] = initParams(epoch)
% This program initialize and preallocate the parameters needed for the
% model. This should be executed before the simulations.
global p a

p.teachingStyle = 2;
% 1 = final reward only
% 2 = intermediate reward
% 3 = final reward only + teacher forcing
% 4 = intermediate reward + teacher forcing

%% modeling parameters
p.runs = epoch;         % training upper lim
p.maxIter = 100;        % terminate if cannot finish in 100 iter
p.wf = .10;             % noise magnitude
p.lrate = .001;         % learning rate
p.gamma = .9;           % discount factor
a.smgain = 1;           % initial softmax rate
p.smirate = .001;       % softmax decrement rate
p.smi_upperLim = 10;    % the upper limit of the smi rate

if p.teachingStyle == 1 || p.teachingStyle == 3
    a.punishFactor = 0.8;   % count how many errors the model made
    p.PFd = .001;
    p.PF_lowerLim = 0.2;
elseif p.teachingStyle == 2 || p.teachingStyle == 4
    a.punishFactor = 1;   % count how many errors the model made
    p.PFd = 0;
    p.PF_lowerLim = 0.2;
else
    error('Unrecognized teaching mode')
end

%% teaching mode
% controls the redo mode
p.teachingModeOn = 0;
p.maxTeachTrial = 100;

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
%     p.r.smallNeg = -0.05;
%     p.r.midNeg = - 1;
%     p.r.bigNeg = - 5;
%     p.r.midPos = 5;
%     p.r.bigPos = 10;
    % scale 
    p.r.smallNeg = 0;
    p.r.midNeg = - 0.1;
    p.r.bigNeg = - 0.5;
    p.r.midPos = 0.5;
    p.r.bigPos = 1;
else
    error('Unrecognized teaching mode')
end


%% actively stop the task
% if the model doesn't move for 5 steps, terminate the task
p.stopCounter = 3;

%% network specific
% initialize with small small random values
a.wts = randSmallWeights(p.mvRange,p.eyeRange);
a.bias = 0.00001;     % bias toward not moving (action 0)

end

