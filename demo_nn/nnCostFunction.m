%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%
function [J grad] = nnCostFunction(nn_params, ...
    input_layer_size, hidden_layer_size, ...
    num_labels, X, y, lambda)
% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
    hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
    num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);

% You need to return the following variables correctly
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
DELTA1 = 0; DELTA2 = 0;

% Computing activation values for each layers
a1 = [ones(m, 1) X];
z2 = a1 * Theta1';
a2 = sigmoid(z2);
a2 = [ones(m,1) a2];
z3  = a2 * Theta2';
a3 = sigmoid(z3);
% For computing y_matrix
I = eye(num_labels);

% Go through every examples
for i = 1:m
    J(i) =  (1 / m) * sum((  -I(y(i),:) .* log(a3(i,:)) -  (1-I(y(i),:)) .* log(1 - a3(i,:))));
    
end
% Summing the Cost with the Regularization term
J = sum(J) + (sum(sum(Theta1(:,2:end).^(2))) + sum(sum(Theta2(:,2:end).^(2)))) * (lambda / ( 2 * m ));


% --------------BACK PROP.--------------

for t = 1:m
    % forward prop
    a1 = [1, X(t,:)];
    z2 = a1 * Theta1';
    a2 = [1, sigmoid(z2)];
    z3  = a2 * Theta2';
    a3 = sigmoid(z3);
    
    % back prop
    delta3 = a3 - I(y(t),:);
    delta2 = (delta3 * Theta2(:,2:end)) .* sigmoidGradient(z2);
    
    % accumulating delta
    DELTA2 = DELTA2 + delta3' * a2;
    DELTA1 = DELTA1 + delta2' * a1;
    
    % calculating gradients
    Theta1_grad = DELTA1 ./ m;
    Theta2_grad = DELTA2 ./ m;
    
end

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + Theta1(:,2:end) * lambda / m;
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + Theta2(:,2:end) * lambda / m;

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
