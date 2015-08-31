function [ choice ] = chooseMax(strengths)
% find the index of the largest element in the input vector
choice = find(strengths == max(strengths));

if numel(choice) > 1
    idx = randperm(numel(choice),1);
    choice = choice(idx);
end
end

