function [p] = setupParameters()
%SETUPPARAMETERS Summary of this function goes here
%   Detailed explanation goes here
p.range = 5;        %
p.gamma = .5;       % discount factor
p.alpha = 0.1;      % learning rate
p.nactions = 2;     % number of possible actions
p.trials = 100;    % training epochs
p.qscale = 3;       % softmax scale factor

end

