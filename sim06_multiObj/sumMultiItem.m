function [cumulativeVisualInput] = sumMultiItem(targPos, sd)
% this function generate cumulative input patterns for multiple objects
global p;

% preallocation
visInput = nan(p.nItems, p.spRange);
% generate visual input for every item
for i = 1 : p.nItems
    visInput(i,:) = normpdf(-p.spRad:p.spRad, targPos(i),sd(i));
end
% sum all visual input, columnwise
cumulativeVisualInput = sum(visInput);

end