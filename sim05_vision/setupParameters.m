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
p.range = 7;            % the size of the state space
p.vRad = 2;             % the radius of the visual span
p.vSpan = p.vRad*2+1;   % range of the percetual span 
p.nEyeAct = p.range;    % number of possible actions
p.nHandAct = p.vSpan;   % only allow to touch things within the span


% reward signals
p.finalR = 2;       % reward for complete counting
p.subR = 0.2;         % reward for touching the obejct
p.punish = -0.1;    % reward for doing touching empty spot

% number of teaching trials
p.teachTrial = 0;
end

