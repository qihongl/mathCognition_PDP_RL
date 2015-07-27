%SETUPPARAMETERS returns the parameters for the model
function [] = setupParameters(epochs)
global p;
% number of training epochs 
p.trials = epochs;  
% modeling parameters
p.gamma = 0.5;       % discount factor
p.alpha = 0.2;      % learning rate
p.qscale = 3;       % softmax scaling factor

% other parameters
p.range = 10;            % the size of the state space
% p.numItems = 3;         % number of items in the world
p.nactions = p.range;   % number of possible actions
p.visualSpan = 5;       % the perceptual span

% reward signals
p.finalR = 2;       % reward for complete counting
p.subR = 0.2;         % reward for touching the obejct
p.punish = -0.1;    % reward for doing touching empty spot

% number of teaching trials
p.teachTrial = 500;
end

