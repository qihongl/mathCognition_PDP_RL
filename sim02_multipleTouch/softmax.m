% SOFTMAX assign probabilities to options
% in my case, x is expected to be a vector of q values for a state: Q(s,:)
function [prob] = softmax(x, scale)
% if there is no input scaling factor, just don't scale it
if nargin == 1 
    scale = 1; 
end

% transform when there is negative values
% TODO: this transformation is not perfect
if any(x < 0)
    x = x - min(x);
end

% softmax transformation
prob = (x.^scale) / sum(x.^scale);

% this should return a probability distribution (mass function)
% so one can check it sum to 1 
% if sum(prob) ~= 1 
%     warning('the sum of the softmax output != 0');
% end
end