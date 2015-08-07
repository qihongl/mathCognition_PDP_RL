function [ ] = showWeights( )
% plot the weights of the model
global p d a;

% plot all weights
axes(d.lineWts);
plot(-p.eyeRad:p.eyeRad,a.wts);

% plot weights around fovea
axes(d.heatWts)
imagesc(a.wts)
end

