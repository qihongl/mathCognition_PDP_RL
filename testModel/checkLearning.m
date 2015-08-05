%% Evaluative the development of the model
clear global; 
global plots p;
%% get data from the current dir 
filename = 'record.mat';
load([pwd '/' filename], 'record')
fprintf('Directory: %s\n', pwd)

%% Prepare for the ploting
initPlot_learning()

%% Compute the performance 
pooledScore = getPooledScores(record, plots.LENGTH);
% scoreByCard = getScoresByCard(record);

%% Plot the performance
% plot the complete rate over time
plotPooledScore(record, pooledScore)