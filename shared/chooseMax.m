function [ choice ] = chooseMax(strengths)
% find the index of the largest element in the input vector
choice = find(strengths == max(strengths));
end

