function [ ] = showWeights( )
% plot the weights of the model
global p d a;

% plot all weights
axes(d.wts1);
imagesc(a.wts1)
colorbar

% plot weights around fovea
axes(d.wts2)
imagesc(a.wts2)
colorbar
end

