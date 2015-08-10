function [finalScore] = evaluateModel_quiz( score, numQs )
%UNTITLED2 Summary of this function goes here
%   This function assume the data is the quiz data
%   Namely, the input data can be converted to "cardinality X numQs matrix"

global p;
numTotalQ = numel(score);

% preallocate
steps = nan(p.maxItems, numQs);
orders = cell(p.maxItems, numQs);
numSkips = nan(p.maxItems, numQs);
completed = nan(p.maxItems, numQs);
numItemsShowed = nan(p.maxItems, numQs);
numErrors = nan(p.maxItems, numQs);
orderCorrect = false(p.maxItems, numQs);

%% save data in "cardinality X numQs" form
for cardinality = 1 : p.maxItems
    for i = 1 : numQs
        tempScore = score{cardinality,i};
        steps(cardinality, i) = tempScore.steps;
        orders{cardinality, i} = getNonzeros(tempScore.indices);
        numSkips(cardinality, i) = detectSkip(orders{cardinality, i});
        completed(cardinality, i) = tempScore.completed;
        numItemsShowed(cardinality, i) = tempScore.nItemsShowed;
        numErrors(cardinality, i) = tempScore.numErrors;
        if ismonotonic(getNonzeros(tempScore.indices))
            orderCorrect(cardinality, i) = true;
        end
    end
end


%% 1. compute summary statistics (combine all cardinality)
% average number of steps used
overall.meanSteps = mean(steps(:));
% don't go right to left
overall.monotonicRate = sum(orderCorrect(:))/ numTotalQ;
% don't skip item
overall.skipRate = 1 - (sum(numSkips(:) == 0) / numTotalQ);
% how many items were skipped
overall.meanNumSkips = mean(numSkips(:));
% whether touch all items within 100 steps
overall.completeRate = sum(completed(:))/numTotalQ;
overall.meanNumErrors = mean(numErrors(:));
% complete without making error
correctCompletedMatrix = bsxfun(@and, numErrors == 0, completed);
overall.correctCompRate = sum(sum(correctCompletedMatrix))/ numTotalQ;

%% 2. compute summary statistics (for every cardinality)
byCard.meanSteps = mean(steps,2);
byCard.monotonicRate = sum(orderCorrect,2)./numQs;
byCard.skipRate = (numQs-sum(numSkips == 0,2))./numQs;
byCard.meanNumSkips = mean(numSkips,2);
byCard.compRate = sum(completed,2)./numQs;
byCard.correctCompRate = sum(correctCompletedMatrix,2)./numQs;
byCard.meanNumErrors = mean(numErrors,2);

% check if the distribution of caridnality is the same
if any(mean(numItemsShowed,2) ~= (1 : p.maxItems)')
    error('cardinality distribution is not uniform.');
end
% now we can assume each caridnality were tested equally

%% print results
tt = sprintf('Performance on %d * %d questions\n', p.maxItems, numQs);
fprintf('------------------------------------------------\n')
fprintf('Directory: "%score"\n', pwd);
fprintf(tt)
fprintf('------------------------------------------------\n')
fprintf('Mean number of steps used: \t%.3f\n',overall.meanSteps )
fprintf('Percent trials monotonic: \t%.2f\n' , overall.monotonicRate)
fprintf('Percent trials completed: \t%.2f\n' , overall.completeRate)
fprintf('Percent trials correct comp: \t%.2f\n' , overall.correctCompRate)
fprintf('Percent trials with skip: \t%.2f\n' , overall.skipRate)
fprintf('Mean number of skips: \t\t%.2f\n' , overall.meanNumSkips)
fprintf('Mean number of errors: \t\t%.2f\n' , overall.meanNumErrors)
fprintf('-\n')
% Performance by cardinality
fprintf('Performance by cardinality: \n')
fprintf('nItems\tmeanStepsUsed\tcompleteRate\tcorrectCompRate\tskipRate\tmeanErrors\n')
for n = 1 : p.maxItems
    fprintf('%d\t', n);
    fprintf('%.2f\t\t', byCard.meanSteps(n));
    fprintf('%4.0f%%\t\t', byCard.compRate(n) * 100);
    fprintf('%4.0f%%\t\t', byCard.correctCompRate(n) * 100);
    fprintf('%4.0f%%\t\t', byCard.skipRate(n) * 100);
    fprintf('%4.2f\t', byCard.meanNumErrors(n));
    fprintf('\n');
end

fprintf('------------------------------------------------\n')

%% save data 
finalScore.overall = overall; 
finalScore.byCard = byCard; 

end



