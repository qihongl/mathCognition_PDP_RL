function [ ] = showWeights( )
% plot the weights of the model
global p d a;

% plot all weights
axes(d.lineWts);
plot(-p.eyeRad:p.eyeRad,a.wts);
title(d.lineWts, 'Weights', 'fontsize', d.FONTSIZE)
xlabel(d.lineWts, 'Visual input layer', 'fontsize', d.FONTSIZE)
ylabel(d.lineWts, 'Strength', 'fontsize', d.FONTSIZE)

% plot weights around fovea
axes(d.heatWts)
imagesc(a.wts)
title(d.heatWts, 'Weights: visual -> action', 'fontsize', d.FONTSIZE)
xlabel(d.heatWts, 'Visual input layer', 'fontsize', d.FONTSIZE)
ylabel(d.heatWts, 'Action layer', 'fontsize', d.FONTSIZE)
end

