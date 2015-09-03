function [ ] = showWeights( )
% plot the weights of the model
global p d a;
% wts from visual input to hidden 
axes(d.wts_VH)
imagesc(a.wts_VH)
title(d.wts_VH, 'Weights: visual -> hidden', 'fontsize', d.FONTSIZE)
xlabel(d.wts_VH, 'Visual input layer', 'fontsize', d.FONTSIZE)
ylabel(d.wts_VH, 'Hidden layer', 'fontsize', d.FONTSIZE)


% wts from visual hidden to action 
axes(d.wts_HA)
imagesc(a.wts_HA)
title(d.wts_HA, 'Weights: hidden -> action', 'fontsize', d.FONTSIZE)
xlabel(d.wts_HA, 'Hidden layer', 'fontsize', d.FONTSIZE)
ylabel(d.wts_HA, 'Action layer', 'fontsize', d.FONTSIZE)

end

function visualizeWeightsMatrix(wts)
global p;
imagesc(-p.eyeRad:p.eyeRad,-p.mvRad:p.mvRad+1, wts)
set(gca,'xtick',-p.eyeRad:1:p.eyeRad);
set(gca,'ytick',-p.mvRad:1:p.mvRad+1);
end