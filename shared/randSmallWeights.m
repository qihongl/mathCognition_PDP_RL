function [ weights ] = randSmallWeights(nRow,nCol)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
epsilon_init = 0.12;
weights = rand(nRow,nCol) * 2 * epsilon_init - epsilon_init;
end

