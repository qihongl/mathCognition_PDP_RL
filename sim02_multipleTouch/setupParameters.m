%SETUPPARAMETERS returns the parameters for the model
function [p] = setupParameters()
% modeling parameters
p.gamma = .5;       % discount factor
p.alpha = 0.1;      % learning rate
p.qscale = 3;       % softmax scale factor

% other parameters
p.range = 5;            % the size of the state space
p.numItems = 3;         % number of items in the word
p.nactions = p.range;   % number of possible actions

% number of training epochs 
p.trials = 100;    % training epochs
end

