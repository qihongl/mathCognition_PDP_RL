function [ redundantSteps ] = getRedunSteps( spotsTouched )
%GETREDUNSTEPS Summary of this function goes here
%   Detailed explanation goes here
NUM_TRIALS = size(spotsTouched,2);

redundantSteps = nan(NUM_TRIALS,1);
for i = 1 : NUM_TRIALS
    redundantSteps(i) = size(spotsTouched{i},2) - size(unique(spotsTouched{i}),2);
end

end

