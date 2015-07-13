%% A function for analyzing the performance of the model 
clear; 
%% load the data
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim06_multiObj/';
PATH.DATA = 'data/record.mat';
% get the data
record = loadData(PATH);

%% read the data
global p a w;
% get the parameters & weights
p = record.p;
a = record.r.results.a;

%% test the model
initPlot();
initState();
updateState();
showState();
i = 0;
while ~(w.done)
    selectAction();
    Act();
    updateState();
    updateWeights();
    showState();
    i = i+1;
end


%% evaluate the performance
% visualize the weights 
% plot(record.r.results.a.wts')