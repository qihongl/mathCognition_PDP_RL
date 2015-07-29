%% Evaluative the development of the model
clear all; clear global; 
global plots p;
%% construct the path to the data files
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim13_oneItem/';
% PATH.DATA = 'data/record_noteach.mat';
PATH.DATA = 'record.mat';

% load the data
fprintf('Testing the model from "%s"\n', PATH.DIR);
load([PATH.ROOT PATH.DIR PATH.DATA], 'record')

%% Prepare for the ploting
initPlot_learning()

%% plot the performance
% plot the steps used to complete each trial
% plotStepsUsed(record)
% plot the complete rate over time
plotPooledScore(record)

