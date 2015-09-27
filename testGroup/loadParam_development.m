%% load parameters
% this function is designed for getting developmental data, which should
% test all weights recorded. 
% 
function [ ] = loadParam_development(record, developEpisode)

global p a; 
% get the parameters & weights
p = record.p;
a = record.a;

% set the weights to the correct developmental stage
a.wts = record.wts{developEpisode};


end

