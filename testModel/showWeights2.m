function [ ] = showWeights2( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global p w d a;
FONTSIZE = 13; 

% plot all weights
axes(d.allWeights);
imagesc(a.wts1)
% imagesc(a.identity)
title(d.allWeights, 'weights - from visual to hidden layer', 'fontsize', FONTSIZE)
ylabel(d.allWeights, 'hidden units', 'fontsize', FONTSIZE);
xlabel(d.allWeights, 'visual input', 'fontsize', FONTSIZE)
colorbar

% plot weights around fovea
axes(d.heatMap)
imagesc(a.wts2)
title(d.heatMap, 'weights - from hidden to action layer', 'fontsize', FONTSIZE)
xlabel(d.heatMap, 'hidden units', 'fontsize', FONTSIZE)
ylabel(d.heatMap, 'actions units', 'fontsize', FONTSIZE)
colorbar
end

