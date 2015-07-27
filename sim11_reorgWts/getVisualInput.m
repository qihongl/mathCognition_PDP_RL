function [cumVisualPattern] = getVisualInput()
% this function generate cumulative input patterns for multiple objects
global p w;

% if w.vS.sd == 0
%     error('Invalid Input: w.vS.sd cannot be zero!');
% end

% preallocation
visInput = nan(w.nItems, p.mvRange);
% generate visual input for every item
for i = 1 : w.nItems
    visInput(i,:) = normpdf(-p.mvRad:p.mvRad, w.vS.targPos(i),w.vS.sd(i));
end
% sum all visual input, columnwise
sumInputs = sum(visInput);
% normalize it so that it sums to 1
cumVisualPattern = sumInputs./sum(sumInputs);
% cumVisualPattern = sumInputs;
end