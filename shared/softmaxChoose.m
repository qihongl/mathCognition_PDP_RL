function [choice_index, choise_onehot] = softmaxChoose(input, temperature)

% scale the input 
input = temperature * input;

% reshape the input to a vector 
input_col = reshape(input, [numel(input),1]);

% compute the softmax distribution
prob = softmaxDistribution(input_col);
cumulativeProb = cumsum(prob);

% take a choice
v = rand; % a number between 0 and 1
choice_index = find(cumulativeProb > v, 1);

% conver the choise to one hot format with the original size 
choise_onehot = false(numel(input),1); 
choise_onehot(choice_index) = true;
choise_onehot = reshape(choise_onehot, size(input));


end