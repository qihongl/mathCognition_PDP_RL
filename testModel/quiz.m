%% This is a quiz for the model
% It come up with N questions and record the performance of the model
function finalScore = quiz(showPlot)
if nargin == 0
    showPlot = false;
end

%% Parameters
dfNumQs = 50;
dfNumPlots = 1;

%% Get data from the current directory
filename = 'record.mat';
datapath = [pwd '/' filename];
load(datapath, 'record');

% add path, in order to use its functions
addpath(pwd)

%% load the data
loadParams(record);

%% How many questions to ask, how many showPlots to show
% number of questions
if showPlot
    showPlot = 1;
    numQs = dfNumPlots;
else
    showPlot = 0;
    numQs = dfNumQs;
end

%% Quiz the model
scores = askQuesitons(numQs, showPlot);

%% show the quiz performance
finalScore = []; 
if ~showPlot
    finalScore = evaluateModel_quiz(scores, numQs);
end

% undo add path, not to mix up the functions
rmpath(pwd);
end