function [cumVisualPattern] = getVisualInput()
% this function generate cumulative input patterns for multiple objects
global p w;

% if w.vS.sd == 0
%     error('Invalid Input: w.vS.sd cannot be zero!');
% end

% preallocation
visInput = nan(w.nItems, p.eyeRange);
% generate visual input for every item
for i = 1 : w.nItems
    cdf_L = normcdf((-p.eyeRad:p.eyeRad) - .5, w.vS.targPos(i),w.vS.sd(i));
    cdf_R = normcdf((-p.eyeRad:p.eyeRad) + .5, w.vS.targPos(i),w.vS.sd(i));
    visInput(i,:) = cdf_R - cdf_L;
end
% sum all visual input, columnwise
sumInputs = sum(visInput,1);
% normalize it so that it sums to 1
% cumVisualPattern = sumInputs./sum(sumInputs);
cumVisualPattern = sumInputs;
end