function [ ] = showWeights( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global p w d a;
FONTSIZE = 13; 

% plot weights from visual input to hidden units
axes(d.wts_VH);
imagesc(a.wts_VH);
title(d.wts_VH, 'weights - line plot', 'fontsize', FONTSIZE)
ylabel(d.wts_VH, 'hidden layer', 'fontsize', FONTSIZE);
xlabel(d.wts_VH, 'visual input layer', 'fontsize', FONTSIZE)
colorbar

% plot weights from hidden units to action units
axes(d.wts_HA)
imagesc(a.wts_HA)
title(d.wts_HA, 'weights - heat map', 'fontsize', FONTSIZE)
xlabel(d.wts_HA, 'hidden layer', 'fontsize', FONTSIZE)
ylabel(d.wts_HA, 'action layer', 'fontsize', FONTSIZE)
colorbar
end

