function [ ] = plotPooledScore(record)
% Assess the model's performance over the time course of learning
% it pools neighbouring 100 trials together when measures the performance
%% initialization 
global p plots;
p = record.p;
period = p.runs / plots.LENGTH;

% resource preallocation
stepsUsed = zeros(period, 1);
completeRate = zeros(period, 1);
% compute the the performance over time 
for i = 1 : period
    % get the completion rate
    completeRate(i) = sum(record.completed((i-1)*plots.LENGTH+1 : i*plots.LENGTH));
    % get the average number of steps used
    stepsUsed(i) = mean(record.steps((i-1)*plots.LENGTH+1 : i*plots.LENGTH));
end


%% start plotting
% axes(plots.compRate)
hold on;
plot(completeRate)
plot(stepsUsed)

% add scripts
xlabel('Time', 'fontsize', plots.FONTSIZE)

legend({'Number of trials completed', 'Average steps used'}, ...
    'FontSize',plots.FONTSIZE)
tt = sprintf('Performance over time (evaluated for every %d trials)',plots.LENGTH);
title(tt, 'fontsize', plots.FONTSIZE);
hold off;

%% statistics
correlation = corr(stepsUsed,completeRate);

%% print the results
fprintf('---------------------------------------------------\n')
fprintf('SUMMARY STATISTICS\n')
fprintf('\tR(stepsUsed,completionRate) = %2.f\n', correlation)
fprintf('---------------------------------------------------\n')

end

