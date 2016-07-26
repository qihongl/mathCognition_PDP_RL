function [ distribution ] = softmaxDistribution( vector )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

distribution = exp(vector) / sum(exp(vector));

end

