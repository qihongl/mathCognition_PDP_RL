%SETUPPARAMETERS returns the parameters for the model
function [p] = setupParameters(epochs)
% modeling parameters
p.gamma = 0.5;       % discount factor
p.alpha = 0.2;      % learning rate
p.qscale = 3;       % softmax scaling factor

% other parameters
p.range = 7;            % the size of the state space
p.numItems = 3;         % number of items in the world
p.nactions = p.range;   % number of possible actions

% number of training epochs 
p.trials = epochs;  

% reward signals
p.finalR = 2;       % reward for complete counting
p.subR = 0;         % reward for touching the obejct
p.punish = -0.1;    % reward for doing touching empty spot
end

