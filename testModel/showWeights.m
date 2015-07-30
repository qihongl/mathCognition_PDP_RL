function [ ] = showWeights( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global p w d a;
FONTSIZE = 13; 

% plot all weights
axes(d.allWeights);
plot(-p.eyeRad:p.eyeRad,a.wts);
title(d.allWeights, 'weights - line plot', 'fontsize', FONTSIZE)
ylabel(d.allWeights, 'strength', 'fontsize', FONTSIZE);
xlabel(d.allWeights, 'visual input', 'fontsize', FONTSIZE)

% plot weights around fovea
axes(d.heatMap)
imagesc(a.wts)
title(d.heatMap, 'weights - heat map', 'fontsize', FONTSIZE)
xlabel(d.heatMap, 'visual input', 'fontsize', FONTSIZE)
ylabel(d.heatMap, 'actions', 'fontsize', FONTSIZE)
colorbar
end

