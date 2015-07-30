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
completedTrialsByCard = zeros(1,p.maxItems);
numItemsFreq = zeros(1,p.maxItems);

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
        completedTrialsByCard(score{i}.nItemsShowed) = completedTrialsByCard(score{i}.nItemsShowed) + 1;
    end
end

% associate numItemShowed with steps used
stepsByCard = zeros(1,p.maxItems);
for n = 1 : p.maxItems
    stepsByCard(n) = mean(steps(numItemsShowed == n));
    numItemsFreq(n) = sum(numItemsShowed == n);
end

completeRateByCard = completedTrialsByCard ./ numItemsFreq;

%% compute summary statistics
% average number of steps used 
meanSteps = mean(steps);
% don't go right to left
monotonicRate = sum(orderCorrect)/ numQs;
% don't skip item 
skipRate = sum(numSkips ~= 0) / numQs;
% touch all items within 100 steps
completeRate = sum(completed)/numQs;

%% print results
tt = sprintf('Performance on %d questions\n', numQs);
fprintf('------------------------------------------------\n')
fprintf('Directory: "%score"\n', pwd);
fprintf(tt)
fprintf('------------------------------------------------\n')
fprintf('Average steps used: \t\t%.3f\n',meanSteps )
fprintf('Percent trial monotonic: \t%.2f\n' , monotonicRate)
fprintf('Percent trial completed: \t%.2f\n' , completeRate)
fprintf('Percent trial with skip: \t%.2f\n' , skipRate)
fprintf('-\n')
fprintf('Performance by cardinality: \n')
fprintf('nItems\t occurance\tcompletionRate\t meanStepsUsed\n')
for n = 1 : p.maxItems
    fprintf('%d\t', n);
    fprintf('%4d (%.2f)\t', numItemsFreq(n), numItemsFreq(n) / numQs);
    fprintf('%4d (%4.2f)\t', completedTrialsByCard(n), completeRateByCard(n));
    fprintf('%6.2f\t', stepsByCard(n));
    fprintf('\n');
end

fprintf('------------------------------------------------\n')
end

