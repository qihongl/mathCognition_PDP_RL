function [col, numSubj, numItems, dataMatrix] = procInput( condition, data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if condition.num ~= length(condition.labels)
    error('ERROR: input label mismatch with the data matrix');
end

if size(data.matrix,2) ~= ...
        (1 + length(data.columLabels.overall) + length(data.columLabels.byCard) * data.numItems)
    error('ERROR: column label mismatch with the size of the data matrix');
end


% read column labels 
col.labels = data.columLabels;
col.num.overall = length(col.labels.overall);
col.num.byCard = length(col.labels.byCard);
% read other info 
numItems = data.numItems;
numSubj = data.numSubj;
dataMatrix = data.matrix;

end

