function [ ] = evaluateModel( score, numQs )
%EVALUATEMODEL evalute the model's performance on the quiz test set
global p; 
% resource preallocation
steps = zeros(1,numQs);
orders = cell(1,numQs);
orderCorrect = true(1,numQs);
numSkips = nan(1,numQs);
numObjTouched  = zeros(1,numQs);
completed = false(1,numQs);
numItemsShowed = zeros(1,numQs);
completedTrialsForEachNum = zeros(1,p.maxItems);

%% process the data 
for i = 1 : length(score)
    steps(i) = score{i}.steps;
    orders{i} = getNonzeros(score{i}.indices);
    if ~ismonotonic(getNonzeros(score{i}.indices))
        orderCorrect(i) = false;
    end
    numSkips(i) = detectSkip(orders{i});
    numObjTouched(i) = length(orders{i});
    completed(i) = score{i}.completed;
    numItemsShowed(i) = score{i}.nItemsShowed;
    if completed(i) == 1
        completedTrialsForEachNum(score{i}.nItemsShowed) = completedTrialsForEachNum(score{i}.nItemsShowed) + 1;
    end
end

%% compute summary statistics
meanSteps = mean(steps);
monotonicRate = sum(orderCorrect)/ numQs;
skipRate = sum(numSkips ~= 0) / numQs;
completeRate = sum(completed)/numQs;
numItemsFreq = tabulate(numItemsShowed);

% table showing performance for every number
table = [(1:p.maxItems)' numItemsFreq(:,2:3) completedTrialsForEachNum' completedTrialsForEachNum'./numItemsFreq(:,2)];

%% print results
tt = sprintf('Performance on %d questions\n', numQs);
fprintf('------------------------------------------------\n')
fprintf(tt)
fprintf('------------------------------------------------\n')
fprintf('Average steps used: \t\t%.3f\n',meanSteps )
fprintf('Percent trial monotonic: \t%.2f\n' , monotonicRate)
fprintf('Percent trial completed: \t%.2f\n' , completeRate)
fprintf('Percent trial with skip: \t%.2f\n' , skipRate)

fprintf('Performance by cardinality \n')
table

end

