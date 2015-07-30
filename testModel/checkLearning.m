%% Evaluative the development of the model
clear all; clear global; 
global plots p;
%% get data from the current dir 
PATH.DATA = 'record.mat';
load([pwd '/' PATH.DATA], 'record')
fprintf('Directory: %s\n', pwd)

%% Prepare for the ploting
initPlot_learning()

%% Compute the performance 
pooledScore = getPooledScores(record);
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