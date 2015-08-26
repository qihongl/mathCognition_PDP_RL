% take average of the weights
clear all; clear global; close all; 
FONTSIZE = 14;

name = 'record';
nsubj = 10; 

% get the weights
wts = cell(nsubj,1);
for i = 1 : nsubj 
    filename = sprintf('%s%.2d.mat', name, i);
    load(filename);
    wts{i} = record.a.wts;
end

% averaging the weights
meanWts = zeros(record.p.mvRange+1, record.p.eyeRange);
for i = 1 : nsubj 
    meanWts = meanWts + wts{i};
end

% visualize it 
imagesc(meanWts / nsubj)
title('Final reward only', 'fontsize', FONTSIZE)
xlabel('Visual input layer', 'fontsize', FONTSIZE)
ylabel('Action layer', 'fontsize', FONTSIZE)
% save the plot 
print([pwd '/' 'meanWts'],'-dpng')