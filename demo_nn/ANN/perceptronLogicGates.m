%% Perceptron simulation - learning logic gates
% this script shows that perceptron can learn AND and OR, but not XOR
clear variables; clc; close all;

% set learning parameters
gateType = 'and';
alpha = .1;
maxEpoch = 30;
method = 'SGD';

%% initialization
% choose the learning task
[INPUTS, TARGET] = genLogicGateAnswer(gateType);
% read param
m = size(INPUTS,1);     % num training examples
n = size(INPUTS,2);     % num features
w = rand(n+1,1) * 0.1;  % init weights
% get input feature vectors (combine with bias)
X = horzcat(INPUTS, ones(m,1))';

%% training
error = nan(maxEpoch,1);
for j = 1 : maxEpoch
    delta = zeros(m,1);
    if strcmp(method,'GD')
        %% Full gradient descent
        % forward prop
        act = X'* w;
        out = stepFunction0(act);
        % compute difference between target and output
        delta = target - out;
        % update weights by the difference
        w = w + alpha * X* delta;
        
    elseif strcmp(method,'SGD')
        %% Stochastic gradient descent
        for i = 1 : m;
            % forward prop
            act = X(:,i)'* w;
            out = stepFunction0(act);
            % compute difference between target and output
            delta(i) = TARGET(i) - out;
            % update weights by the difference
            w = w + alpha * X(:,i)* delta(i);
        end
        
    else
        error('unrecognizable learning method')
    end
    % get error measure
    error(j) = sum(abs(delta));
end

%% show performance metric
% show learned output
horzcat(INPUTS, stepFunction0(X' * w))     % final output 
error(end)                                 % final error 

% plot error curve
plot(error)
FS = 14;
title_text = sprintf('Learning curve with %s, alpha = %.2f', ...
     method, alpha);
title(title_text, 'fontsize', FS)
xlabel('Epoch', 'fontsize', FS);ylabel('Error', 'fontsize', FS);