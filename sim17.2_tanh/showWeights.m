function [ ] = showWeights( )
% plot the weights of the model
global p d a;

% plot all weights
axes(d.wts_VH);
imagesc(a.wts_VH)
colorbar
title(d.wts_VH, 'Weights: visual -> hidden', 'fontsize', d.FONTSIZE)
xlabel(d.wts_VH, 'Visual input layer', 'fontsize', d.FONTSIZE)
ylabel(d.wts_VH, 'Hidden layer', 'fontsize', d.FONTSIZE)

% plot weights around fovea
axes(d.wts_HA)
imagesc(a.wts_HA)
title(d.wts_HA, 'Weights: hidden -> action', 'fontsize', d.FONTSIZE)
xlabel(d.wts_HA, 'Hidden layer', 'fontsize', d.FONTSIZE)
ylabel(d.wts_HA, 'Action output layer', 'fontsize', d.FONTSIZE)
end

