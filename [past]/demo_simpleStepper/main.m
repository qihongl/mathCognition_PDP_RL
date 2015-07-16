%% counting simulation
clear; clc % clear things up

%
nSubj = 10;
temp = zeros(100,1);
for i = 1 : nSubj
    run = counting(i, false);
    temp = temp + run.h.stepsToReward;
end

plot(temp/nSubj)