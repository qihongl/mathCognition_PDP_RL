%% This is a quiz for the model
% It come up with N questions and record the performance of the model
function quiz(plot)
if nargin == 0
    plot = false;
end 
%% Parameters
% number of questions
if plot
    showPlot = 1;
    numQs = 1;
else 
    showPlot = 0;
    numQs = 500;
end

%% Construct data path
% construct the path to the data files
% PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
% PATH.DIR = 'sim14_cdf';
% PATH.DATA = 'smg/record_smg1.mat';
% load([PATH.ROOT PATH.DIR '/' PATH.DATA], 'record')

% addpath([PATH.ROOT PATH.DIR])
PATH.DATA = 'record.mat';
load([pwd '/' PATH.DATA], 'record')
% add path, in order to use its functions
addpath(pwd)




%% load the data

global p a;
loadParams(record);

%% Quiz the model 
% preallocate 
score = cell(1,numQs);
fprintf('Start testing: %d questions\n', numQs)
for i = 1: numQs
    % progress bar
    fprintf('%d\n', i)
    % test the model 
    score{i} = testModel(showPlot);
end
fprintf('\n')

%% show the quiz performance 
if ~showPlot
    evaluateModel(score, numQs)
end
% undo add path, not to mix up the functions 
% rmpath([PATH.ROOT PATH.DIR])
rmpath(pwd)
end
