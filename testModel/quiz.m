%% This is a quiz for the model
% It come up with N questions and record the performance of the model

%% Parameters
% number of questions
showPlot = 0;
numQs = 1;
%% construct the path to the data files
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim07_teach/';
PATH.DATA = 'data/record_noTeach.mat';
% PATH.DATA = 'record.mat';
% get the data
load([PATH.ROOT PATH.DIR PATH.DATA], 'record')
addpath([PATH.ROOT PATH.DIR])

%% load the data
global p a;
% get the parameters & weights
p = record.p;
a = record.a{size(record.a,2)};


%% Quiz
% preallocate
s = cell(1,numQs);
textprogressbar('Quiz in progress: ')
for i = 1: numQs
    textprogressbar(i)
    % do the test
    s{i} = testModel(i,showPlot);
end
textprogressbar(' Done.')


%% grade the quiz
% preallocate
steps = zeros(1,numQs);
orders = cell(1,numQs);
for i = 1 : size(s,2)    
    steps(i) = s{i}.steps;
    orders{i} = getOrder(s{i}.indices);
end



%%
rmpath([PATH.ROOT PATH.DIR])

