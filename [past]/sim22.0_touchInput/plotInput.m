function [  ] = plotInput( input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

subplot(2,1,1)
visInput = input(1:31);
plot(visInput)

subplot(2,1,2)
sensoryInput = input(32:end);
plot(sensoryInput)



end

