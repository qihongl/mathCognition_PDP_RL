function [ ] = showWeights( )
% plot the weights of the model
global p d a;

% plot all weights
axes(d.wts1);
imagesc(a.wts_VH)
colorbar

% plot weights around fovea
axes(d.wts2)
imagesc(a.wts_HA)
colorbar
end

