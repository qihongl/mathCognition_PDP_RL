function [ ] = plotPooledScore(record, ps)
% Assess the model's performance over the time course of learning
% it pools neighbouring 100 trials together when measures the performance
%% initialization 
global p plots;
p = record.p;

%% compute some summary statistics
correlation = corr(ps.stepsUsed,ps.completeRate);

%% start plotting
% axes(plots.compRate)
figure;
hold on;
plot(ps.stepsUsed, 'LineWidth',plots.WIDTH)
plot(ps.completeRate * 100 / plots.LENGTH, 'LineWidth',plots.WIDTH)
plot(ps.propItemsTouched * 100, 'LineWidth',plots.WIDTH)
plot(ps.propSkips * 100, 'LineWidth',plots.WIDTH)
plot(ps.meanNumErrors, 'LineWidth',plots.WIDTH)

% add scripts
stepsLegend = sprintf('Average steps used (max == %d)', p.maxIter);
legend({stepsLegend, 'Proportion trials completed * 100', ...
    'Proportion items touched * 100', 'Proportion items skipped * 100', ...
    'Mean Number of errors'}, ...
    'FontSize',plots.FONTSIZE)

xlb = sprintf('Time (pooling data for every %d trials)',plots.LENGTH);
xlabel(xlb, 'fontsize', plots.FONTSIZE)
ylim([0, 100]);
tt = sprintf('Performance over time');
title(tt, 'fontsize', plots.FONTSIZE);

hold off;
end

