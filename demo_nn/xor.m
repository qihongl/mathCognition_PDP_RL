%% Try the XOR problem
close all; clear all;  

%% initialization
% set up the objective mapping 
input = [0 0; 0 1; 1 0; 1 1]';
target = [0 1 1 0];
p.epochs = 10000;
p.lrate = 0.01;
% get the dimensions
[numInput N] = size(input);
[numOutput N] = size(target);
numHidden = 3;
% initialize the weights
wts1 = randSmallWeights(numHidden,numInput);
wts2 = randSmallWeights(numOutput,numHidden);

%% start training
for iter = 1 : p.epochs; 
    for i =  1 : N
        % forward propagation
        hiddenIn = wts1 * input(:,i);
        hiddenAct = sigmoid(hiddenIn);
        outputIn = wts2 * hiddenAct;
        outputAct = sigmoid(outputIn);
        % compute delta for all units
        delta3 = target(i) - outputAct;
        delta2 = wts2' * delta3 .* (hiddenAct .* (1-hiddenAct));
        % update the weights
        wts2_change = delta3 * hiddenAct';
        wts1_change = delta2 * input(:,i)';
        wts2 = wts2 + p.lrate * wts2_change;
        wts1 = wts1 + p.lrate * wts1_change;
        
    end
end

hiddenActivation = sigmoid(wts1 * input);
outputActivation = sigmoid(wts2 * hiddenActivation)
error = target - round(outputActivation)
