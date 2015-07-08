%SETUPPARAMETERS returns the parameters for the model
function [p] = setupParameters(epochs)
% number of training epochs 
p.trials = epochs;  
% modeling parameters
p.gamma = 0.5;      % discount factor
p.alpha = 0.2;      % learning rate
p.qscale = 3;       % softmax scaling factor

% other parameters
p.range = 10;           % the size of the state space
p.visualRadius = 2;     % the perceptual span
p.nActions = 2 * p.visualRadius + 1;   % number of possible actions

% reward signals
p.finalR = 2;       % reward for complete counting
p.subR = 0.2;       % reward for touching the obejct
p.punish = -0.1;    % reward for doing touching empty spot

end
