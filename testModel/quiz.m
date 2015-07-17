%% This is a quiz for the model
% It come up with N questions and record the performance of the model
clear all;
%% Parameters
% number of questions
showPlot = 0;
numQs = 1000;
%% construct the path to the data files
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim08_moreSim/';
% PATH.DATA = 'data/record_noteach.mat';
PATH.DATA = 'record.mat';
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


%% show the quiz performance 
% preallocate
steps = zeros(1,numQs);
orders = cell(1,numQs);
orderCorrect = true(1,numQs);
numSkips = nan(1,numQs);
numObjTouched  = zeros(1,numQs);
% process the data 
for i = 1 : size(s,2)    
    steps(i) = s{i}.steps;
    orders{i} = getOrder(s{i}.indices);
    if ~ismonotonic(getOrder(s{i}.indices))
        orderCorrect(i) = false;
    end
    numSkips(i) = detectSkip(orders{i});
    numObjTouched(i) = length(orders{i});
end

% compute summary statistics
meanSteps = mean(steps);
monotonicRate = sum(orderCorrect)/ numQs;
skipRate = sum(numSkips ~= 0) / numQs;
incompleteRate = sum(steps == p.maxIter) / numQs;


%% print results
fprintf('------------------------------------------------\n')
fprintf('Performance on %d questions: without teaching\n', numQs)
fprintf('------------------------------------------------\n')
fprintf('Average steps used: \t\t%.3f\n',meanSteps )
fprintf('Percent trial monotonic: \t%.2f\n' , monotonicRate)
fprintf('Percent trial with skip: \t%.2f\n' , skipRate)
fprintf('Percent trial incomplete: \t%.2f\n' , incompleteRate)
fprintf('Tabulate number of objects touched: \n')
tabulate(numObjTouched)




%%
rmpath([PATH.ROOT PATH.DIR])

