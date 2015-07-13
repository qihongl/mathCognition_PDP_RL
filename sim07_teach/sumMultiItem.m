function [cumVisualPattern] = sumMultiItem(targPos, sd)
% this function generate cumulative input patterns for multiple objects
global p w;

% if sd == 0
%     error('Invalid Input: sd == 0');
% end

% preallocation
visInput = nan(w.nItems, p.spRange);
% generate visual input for every item
for i = 1 : w.nItems
    visInput(i,:) = normpdf(-p.spRad:p.spRad, targPos(i),sd(i));
end
% sum all visual input, columnwise
sumInputs = sum(visInput);
% normalize it so that it sums to 1
cumVisualPattern = sumInputs./sum(sumInputs);
end