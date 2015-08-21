%% Try the XOR problem
close all; clear all;  

%% initialization
% set up the objective mapping 
input = [0 0; 0 1; 1 0; 1 1]';
target = [0 0 1 1];
p.epochs = 1000;
p.lrate = 0.001;
% get the dimensions
[numInput N] = size(input);
[numOutput N] = size(target);
% initialize the weights
wts = randSmallWeights(numOutput,numInput);

%% start training
for iter = 1 : p.epochs; 
    for i =  1 : N
        % forward propagation
        outputIn = wts * input(:,i);
        outputAct = sigmoid(outputIn);
        % compute delta for all units
        delta = target(i) - outputAct;
        % update the weights
        wts1_change = delta * outputIn;
        wts = wts + p.lrate * wts1_change;
        
    end
end

outputActivation = sigmoid(wts * input)
error = target - round(outputActivation)
