function [ prob ] = logisticTransform( input, temperature )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
prob = 1 ./ (1 + exp( - temperature * input));

end

