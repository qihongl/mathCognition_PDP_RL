function [finalScore] = evaluateModel_quiz( score, numQs, showResults)
if nargin < 3
    showResults = true;
end
%   This function assume the data is the quiz data
%   Namely, the input data can be converted to "cardinality X numQs matrix"

global p;
if numel(score) ~= p.maxItems * numQs
    error('Size of the data is strange');
end

% preallocate
s = resourcePreallocation(numQs);

%% save data in "cardinality X numQs" form
for cardinality = 1 : p.maxItems
    for i = 1 : numQs
        tempScore = score{cardinality,i};
        s.steps(cardinality, i) = tempScore.steps;
        s.orders{cardinality, i} = getNonzeros(tempScore.indices);
        if any(s.orders{cardinality,i} == p.maxItems +1) && length(s.orders{cardinality,i}) -1  < cardinality
            s.stopEarly(cardinality, i) = true;
        end
        % delete "finish" unit
        s.orders{cardinality, i} = s.orders{cardinality, i}(s.orders{cardinality, i} ~= p.maxItems + 1);
        s.numSkips(cardinality, i) = detectSkip(s.orders{cardinality, i});
        s.completed(cardinality, i) = tempScore.completed;
        s.numItemsShowed(cardinality, i) = tempScore.nItemsShowed;
        s.numErrors(cardinality, i) = tempScore.numErrors;
        s.numSkips2(cardinality, i) = tempScore.numSkips;
        s.numDoubleTouch(cardinality, i) = tempScore.numDoubleTouch;
        if ismonotonic(getNonzeros(tempScore.indices))
            s.orderCorrect(cardinality, i) = true;
        end
    end
    
end

% get data for overall performance and data separated by cardinality 
[overall, byCard] = getData(s, numQs);

% check if the distribution of caridnality is the same
if any(mean(s.numItemsShowed,2) ~= (1 : p.maxItems)')
    error('cardinality distribution is not uniform.');
end
% now we can assume each caridnality were tested equally

%% print results
if showResults
    printResultsToConsole(numQs, overall, byCard)
end
%% save data
finalScore.overall = overall;
finalScore.byCard = byCard;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Some helper functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preallocate for scores
function [s] = resourcePreallocation(numQs)
global p; 

% number of total questions 
s.numTotalQ = p.maxItems * numQs;

% preallocate some space for saving the results
s.steps = nan(p.maxItems, numQs);
s.orders = cell(p.maxItems, numQs);
s.completed = nan(p.maxItems, numQs);
s.numItemsShowed = nan(p.maxItems, numQs);
s.numErrors = nan(p.maxItems, numQs);
s.numSkips = nan(p.maxItems, numQs);
s.numSkips2 = nan(p.maxItems, numQs);
s.numDoubleTouch = nan(p.maxItems, numQs);
s.orderCorrect = false(p.maxItems, numQs);
s.stopEarly = false(p.maxItems, numQs);
end

%% get data for overall performance and data separated by cardinality 
function [overall, byCard] = getData(s, numQs)

%% 1. compute summary statistics (combine all cardinality)
% average number of steps used
overall.meanSteps = mean(s.steps(:));
% don't go right to left
overall.monotonicRate = sum(s.orderCorrect(:))/ s.numTotalQ;
% don't skip item
overall.skipRate = 1 - (sum(s.numSkips(:) == 0) / s.numTotalQ);
% how many items were skipped
overall.meanNumSkips = mean(s.numSkips(:));
overall.meanNumSkips2 = mean(s.numSkips2(:)); % second way of computing numSkips
% times of double touching
overall.meanNumDoubleTouch = mean(s.numDoubleTouch(:));
% whether touch all items within 100 steps
overall.completeRate = sum(s.completed(:))/s.numTotalQ;
overall.meanNumErrors = mean(s.numErrors(:));
% complete without making error
correctCompletedMatrix = bsxfun(@and, s.numErrors == 0, s.completed);
overall.correctCompRate = sum(sum(correctCompletedMatrix))/ s.numTotalQ;
% stop early rate
overall.stopEarlyRate = sum(s.stopEarly(:)) / s.numTotalQ;

%% 2. compute summary statistics (for every cardinality)
byCard.meanSteps = mean(s.steps,2);
byCard.compRate = sum(s.completed,2)./numQs;
byCard.correctCompRate = sum(correctCompletedMatrix,2)./numQs;
byCard.monotonicRate = sum(s.orderCorrect,2)./numQs;
byCard.skipRate = (numQs-sum(s.numSkips == 0,2))./numQs;
byCard.meanNumSkips = mean(s.numSkips,2);
byCard.meanNumSkips2 = mean(s.numSkips2,2);
byCard.meanNumDoubleTouch = mean(s.numDoubleTouch,2);
byCard.meanNumErrors = mean(s.numErrors,2);
byCard.stopEarlyRate = sum(s.stopEarly,2) / numQs;

end


%% print the summary results
function printResultsToConsole(numQs, overall, byCard)
global p; 

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
fprintf('Percent trials stopped early: \t%.2f\n' , overall.stopEarlyRate)
fprintf('Mean number of skips: \t\t%.2f\n' , overall.meanNumSkips)
fprintf('Mean number of errors: \t\t%.2f\n' , overall.meanNumErrors)
fprintf('-\n')
% Performance by cardinality
fprintf('Performance by cardinality: \n')
fprintf('nItems StepsUsed compRate  cCompRate numErrors numSkips numDTs stopEarlyRate\n')
for n = 1 : p.maxItems
    fprintf('%d\t', n);
    fprintf('%.2f', byCard.meanSteps(n));
    fprintf('%10.0f%%  ', byCard.compRate(n) * 100);
    fprintf('%6.0f%%', byCard.correctCompRate(n) * 100);
    fprintf('%10.2f\t', byCard.meanNumErrors(n));
    fprintf('%4.2f', byCard.meanNumSkips2(n));
    fprintf('%8.2f', byCard.meanNumDoubleTouch(n));
    fprintf('%8.2f%%', byCard.stopEarlyRate(n)*100);
    fprintf('\n');
end

fprintf('------------------------------------------------\n')
end
