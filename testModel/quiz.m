%% This is a quiz for the model
% It come up with N questions and record the performance of the model
clear all;
%% Parameters
% number of questions
showPlot = 1;
numQs = 10;
tt = sprintf('Performance on %d questions\n', numQs);
% construct the path to the data files
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim09_activeEnd/';
% PATH.DATA = 'smg/record_smg1.mat';
PATH.DATA = 'record.mat';
% get the data
load([PATH.ROOT PATH.DIR PATH.DATA], 'record')
addpath([PATH.ROOT PATH.DIR])

%% load the data
global p a;
% get the parameters & weights
p = record.p;
a = record.a;
a.smgain = 10;

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


%% show the quiz performance 
% preallocate
steps = zeros(1,numQs);
orders = cell(1,numQs);
orderCorrect = true(1,numQs);
numSkips = nan(1,numQs);
numObjTouched  = zeros(1,numQs);
completed = false(1,numQs);
% process the data 
for i = 1 : length(s)
    steps(i) = s{i}.steps;
    orders{i} = getOrder(s{i}.indices);
    if ~ismonotonic(getOrder(s{i}.indices))
        orderCorrect(i) = false;
    end
    numSkips(i) = detectSkip(orders{i});
    numObjTouched(i) = length(orders{i});
    completed(i) = s{i}.completed;
end

% compute summary statistics
meanSteps = mean(steps);
monotonicRate = sum(orderCorrect)/ numQs;
skipRate = sum(numSkips ~= 0) / numQs;
completeRate = sum(completed)/numQs;


%% print results
fprintf('------------------------------------------------\n')
fprintf(tt)
fprintf('------------------------------------------------\n')
fprintf('Average steps used: \t\t%.3f\n',meanSteps )
fprintf('Percent trial monotonic: \t%.2f\n' , monotonicRate)
fprintf('Percent trial completed: \t%.2f\n' , completeRate)
fprintf('Percent trial with skip: \t%.2f\n' , skipRate)


%%
rmpath([PATH.ROOT PATH.DIR])

