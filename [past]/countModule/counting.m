%% a model that say the count words
% the model can count to N, it has N output units corresponds to the N
% count words and an additional units represents saying nothing. Initially,
% it has a bias towards saying nothing. 
clear all; 
% initialization 
global p nn w a; 


%% forward prop. 
% start unit sends activation to all units
nn.numIn = nn.wts_start * w.goal; 
nn.numAct = sigmoid(nn.numIn);
% bias towards the last unit
nn.numAct(length(nn.numAct)) = nn.numAct(length(nn.numAct)) + nn.bias; 

% choose action
a.numOut = choose(nn.numAct .^2);

%% reward 
if a.numOut - w.answer == 1 
    w.answer = w.answer + 1; 
    w.reward = 1; 
    if a.numOut == w.goal
        w.reward = 2; 
    end
end

