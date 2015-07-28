function [ ] = evaluateModel( score, numQs )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
steps = zeros(1,numQs);
orders = cell(1,numQs);
orderCorrect = true(1,numQs);
numSkips = nan(1,numQs);
numObjTouched  = zeros(1,numQs);
completed = false(1,numQs);
% process the data 
for i = 1 : length(score)
    steps(i) = score{i}.steps;
    orders{i} = getOrder(score{i}.indices);
    if ~ismonotonic(getOrder(score{i}.indices))
        orderCorrect(i) = false;
    end
    numSkips(i) = detectSkip(orders{i});
    numObjTouched(i) = length(orders{i});
    completed(i) = score{i}.completed;
end

% compute summary statistics
meanSteps = mean(steps);
monotonicRate = sum(orderCorrect)/ numQs;
skipRate = sum(numSkips ~= 0) / numQs;
completeRate = sum(completed)/numQs;



%% print results
tt = sprintf('Performance on %d questions\n', numQs);
fprintf('------------------------------------------------\n')
fprintf(tt)
fprintf('------------------------------------------------\n')
fprintf('Average steps used: \t\t%.3f\n',meanSteps )
fprintf('Percent trial monotonic: \t%.2f\n' , monotonicRate)
fprintf('Percent trial completed: \t%.2f\n' , completeRate)
fprintf('Percent trial with skip: \t%.2f\n' , skipRate)

end

