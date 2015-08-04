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





% %% construct the path to the data files
% PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
% PATH.DIR = 'sim14_cdf/';
% % PATH.DATA = 'data/record_noteach.mat';
% PATH.DATA = 'record.mat';
% % load the data
% % fprintf('Testing the model from "%s"\n', PATH.DIR);
% load([PATH.ROOT PATH.DIR PATH.DATA], 'record')