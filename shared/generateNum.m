function number = generateNum(N)
%% It decides the number of items of the couting task. 
% Small numbers are more likely to appear. 

% parameters
alpha = 1;
n = 1 : N;
% P(n) = 1 / n ^ alpha
prob = 1 ./ (n .^ alpha);
% choose the number 
number = choose(prob);
end
