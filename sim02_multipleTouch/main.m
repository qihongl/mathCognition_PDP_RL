%% counting simulation
clear; clc % clear things up

nSubj = 20;
temp = zeros(100,1);
for i = 1 : nSubj
    run = touch(i, false);
    temp = temp + run.h.stepsToReward;
end

%% plot performance
FONTSIZE = 14;
hold on 
plot(temp/nSubj)
plot(ones(100,1) * run.p.range)
hold off

t = sprintf('Performance against time, average across %d models', nSubj);
title(t, 'fontsize', FONTSIZE)
xlabel('epochs', 'fontsize', FONTSIZE);
ylabel('steps used', 'fontsize', FONTSIZE);
mylegend = legend('number of steps used',...
    'number of spots in the world');
set(mylegend,'FontSize',FONTSIZE);





