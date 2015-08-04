function [ ] = showWeights( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global p w d a;
FONTSIZE = 13; 

% plot all weights
axes(d.wts_VH);
imagesc(a.wts_VH);
title(d.wts_VH, 'weights - line plot', 'fontsize', FONTSIZE)
ylabel(d.wts_VH, 'strength', 'fontsize', FONTSIZE);
xlabel(d.wts_VH, 'visual input', 'fontsize', FONTSIZE)

% plot weights around fovea
axes(d.wts_HA)
imagesc(a.wts_HA)
title(d.wts_HA, 'weights - heat map', 'fontsize', FONTSIZE)
xlabel(d.wts_HA, 'visual input', 'fontsize', FONTSIZE)
ylabel(d.wts_HA, 'actions', 'fontsize', FONTSIZE)
colorbar
end

