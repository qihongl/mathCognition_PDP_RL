% written by Professor Jay McClelland
function [ ] = setupWorld()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global w a p;

% w = struct([]);
% p = struct([]);
% a = struct([]);

p.range = 5;        % 
p.gamma = .5;       % discount factor
p.alpha = 0.1;      % learning rate
p.qscale = 3;       % softmax scale factor
p.nactions = 2;     % number of possible actions
p.trials = 200;    % training epochs

% preallocate and initilize Q to small values
a.q = .01 + zeros(2*p.range+1,p.nactions);

end

