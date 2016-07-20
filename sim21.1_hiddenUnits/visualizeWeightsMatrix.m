function visualizeWeightsMatrix(wts)
global p;
imagesc(-p.eyeRad:p.eyeRad,-p.mvRad:p.mvRad+1, wts)
set(gca,'xtick',-p.eyeRad:1:p.eyeRad);
set(gca,'ytick',-p.mvRad:1:p.mvRad+1);
end