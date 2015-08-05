function [] = showWeights()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global p w d a;
FONTSIZE = 13; 

% plot weights from visual input to hidden units
axes(d.wts_VH);
imagesc(a.wts_VH);
title(d.wts_VH, 'weights: hidden->visual', 'fontsize', FONTSIZE)
ylabel(d.wts_VH, 'hidden layer', 'fontsize', FONTSIZE);
xlabel(d.wts_VH, 'visual input layer', 'fontsize', FONTSIZE)
colorbar

% plot weights from hidden units to action units
axes(d.wts_HA)
imagesc(a.wts_HA)
title(d.wts_HA, 'weights: hidden->action', 'fontsize', FONTSIZE)
xlabel(d.wts_HA, 'hidden layer', 'fontsize', FONTSIZE)
ylabel(d.wts_HA, 'action layer', 'fontsize', FONTSIZE)
colorbar

% plot weights from number units to hidden units
axes(d.wts_NH)
imagesc(a.wts_NH)
title(d.wts_NH, 'weights: number->hidden', 'fontsize', FONTSIZE)
xlabel(d.wts_NH, 'number prev layer', 'fontsize', FONTSIZE)
ylabel(d.wts_NH, 'hidden layer', 'fontsize', FONTSIZE)
colorbar

% plot weights from hidden units to number output units
axes(d.wts_HN)
imagesc(a.wts_HN)
title(d.wts_HN, 'weights: hidden->number', 'fontsize', FONTSIZE)
xlabel(d.wts_HN, 'hidden layer', 'fontsize', FONTSIZE)
ylabel(d.wts_HN, 'number output layer', 'fontsize', FONTSIZE)
colorbar

end

