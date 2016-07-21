function [ ] = showWeights( )
% plot the weights of the model
global p d a;
% plot weights around fovea
axes(d.heatWts)
% imagesc(-p.eyeRad:p.eyeRad,-p.mvRad:p.mvRad+1, a.wts)
visualizeWeightsMatrix(a.wts)
title(d.heatWts, 'Weights: visual -> action', 'fontsize', d.FONTSIZE)
xlabel(d.heatWts, 'Visual input layer', 'fontsize', d.FONTSIZE)
ylabel(d.heatWts, 'Action layer', 'fontsize', d.FONTSIZE)
end

% function visualizeWeightsMatrix(wts)
% global p;
% imagesc(-p.eyeRad:p.eyeRad,-p.mvRad:p.mvRad+1, wts)
% set(gca,'xtick',-p.eyeRad:1:p.eyeRad);
% set(gca,'ytick',-p.mvRad:1:p.mvRad+1);
% end