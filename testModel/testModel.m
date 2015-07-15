%% An 'exam' for the model
% this function takes a set of trained weights and parameters, come up with
% a counting question, let the model do the counting, and records its
% performance! So it is in some sense an exam for the model.
function [score] = testModel(seed)
if nargin == 0
    seed = randi(999);
end
rng(seed)
%% construct the path to the data files
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim07_teach/';
% PATH.DATA = 'data/record.mat';
PATH.DATA = 'record.mat';
% get the data
% record = loadData(PATH);
load([PATH.ROOT PATH.DIR PATH.DATA], 'record')
addpath([PATH.ROOT PATH.DIR])

%% load the data
global p a w;
% get the parameters & weights
p = record.p;
a = record.a{size(record.a,2)};

%% test the model
% initialization
initPlot();
initState();
updateState();
showState();
w.rS    % show the initial state
i = 0;
score.indices = zeros(1,100);
% test the model
while ~(w.done) && i < 100
    selectAction();
    Act();
    updateState();
    updateWeights();
    showState();
    score.indices(i+1) = recordAction();
    i = i+1;
end

%% evaluate the performance


%%
rmpath([PATH.ROOT PATH.DIR])
end