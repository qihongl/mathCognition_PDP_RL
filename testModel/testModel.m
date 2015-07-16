%% An little quiz for the model
% this function takes a set of trained weights and parameters, come up with
% a counting question, let the model do the counting, and records its
% performance! So it is in some sense a little quiz for the model.
function [score] = testModel(seed, showPlot)
if nargin == 0
    seed = randi(999);
    showPlot = 1;
end
rng(seed)
%% construct the path to the data files
% PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
% PATH.DIR = 'sim07_teach/';
% PATH.DATA = 'data/record_noTeach.mat';
% % PATH.DATA = 'record.mat';
% % get the data
% load([PATH.ROOT PATH.DIR PATH.DATA], 'record')
% addpath([PATH.ROOT PATH.DIR])

% %% load the data
global p a w;
% % get the parameters & weights
% p = record.p;
% a = record.a{size(record.a,2)};

%% test the model
% initialization

initState();
updateState();
if showPlot
    initPlot();
    showState();
end
% w.rS    % show the initial state
i = 0;
score.indices = zeros(1,100);
% test the model
while ~(w.done) && i < 100
    selectAction();
    Act();
    updateState();
    updateWeights();
    if showPlot
        showState();
    end
    % record the action sequence 
    score.indices(i+1) = recordAction();
    i = i+1;
end
% record the steps used
score.steps = i;

%%
% rmpath([PATH.ROOT PATH.DIR])
end