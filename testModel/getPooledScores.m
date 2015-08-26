function [ ps ] = getPooledScores( record, PERIOD_LENGTH )
% get pooled performance for every N tirals 
%% initialization 
global p;
p = record.p;
period = p.runs / PERIOD_LENGTH;

%% get the data
% resource preallocation
stepsUsed = zeros(period, 1);
completeRate = zeros(period, 1);
numItemsShowed = zeros(period, 1);
propItemsTouched = zeros(period, 1);
propSkips = zeros(period, 1);
meanNumErrors = zeros(period, 1);

% get num item skipped for every trial;
numSkips = zeros(1, p.runs);
for i = 1 : p.runs
    order = getNonzeros(record.s.indices{i});
    numSkips(i) = detectSkip(order);
end

%% compute the the performance over time 
for i = 1 : period
    % get a vector of indices for the current period of time points
    currentPeriod = (i-1)*PERIOD_LENGTH+1 : i*PERIOD_LENGTH;
    
    % get the completion rate
    completeRate(i) = sum(record.s.completed(currentPeriod));
    % get the average number of steps used
    stepsUsed(i) = mean(record.s.steps(currentPeriod));
    % get the number of items showed to the model in a period
    numItemsShowed(i) = sum(record.s.numItemsShowed(currentPeriod));
    % get proportion of items skipped by the model in a period 
    propSkips(i) = sum(numSkips(currentPeriod)) / numItemsShowed(i);
    % loop with in every period
    numTouched = 0;
    for j = currentPeriod
        % compute how many items the model touched
        numTouched = numTouched + sum(getNonzeros(record.s.indices{j})~= (p.maxItems+1));
    end
    % divide by how many items the model saw, to get a 'touch rate'
    propItemsTouched(i) = numTouched / numItemsShowed(i);
    meanNumErrors(i) = sum(record.s.numErrors(currentPeriod)) / PERIOD_LENGTH;
end

%% save pooled socres
ps.completeRate = completeRate;
ps.stepsUsed = stepsUsed;
ps.propItemsTouched = propItemsTouched;
ps.propSkips = propSkips;
ps.meanNumErrors = meanNumErrors;

end

