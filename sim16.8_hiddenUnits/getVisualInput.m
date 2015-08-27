function [cumVisualPattern] = getVisualInput()
% this function generate cumulative input patterns for multiple objects
global p w;

visInput = nan(w.nItems, p.eyeRange);
%% generate visual input for every item
for i = 1 : w.nItems
    visualCDF = normcdf((-p.eyeRad:p.eyeRad+1) - .5, w.vS.targPos(i),w.vS.sd(i));
    % approximate the area of the rectangular region under PDF using its CDF
    visInput(i,:) = visualCDF(2:end) - visualCDF(1:length(visualCDF)-1);
end
%% sum all visual input, columnwise, no normalization 
cumVisualPattern = sum(visInput,1);
end