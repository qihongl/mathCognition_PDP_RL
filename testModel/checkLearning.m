%% Evaluative the development of the model
clear global; 
global plots p;
%% Get data from the current dir 
filename = 'record01.mat';
load([pwd '/' filename], 'record');
fprintf('Directory: %s\n', pwd);

%% Prepare for the ploting
initPlot_learning();

%% Compute the performance 
pooledScore = getPooledScores(record, plots.LENGTH);

%% Plot the performance
plotPooledScore(record, pooledScore);