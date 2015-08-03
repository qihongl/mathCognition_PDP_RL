function output = sigmoid(z)
%SIGMOID Compute sigmoid functoon
%   J = SIGMOID(z) computes the sigmoid of z.

output = 1.0 ./ (1.0 + exp(-z));

% bound the output 
upperBound = 0.9998;
lowerBound = 0.0002;
output(output > upperBound) = upperBound;
output(output > lowerBound) = lowerBound;
end
