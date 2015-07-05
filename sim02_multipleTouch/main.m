%% counting simulation
clear; clc % clear things up

% set simulation parameters
nSubj = 20;
numtrials = 100;

%% analysis
% averaging the data
temp = zeros(numtrials,1);
for i = 1 : nSubj
    out = touch(i, false);
    temp = temp + out.h.stepsUsed;
    
end

%% plot performance
FONTSIZE = 14;
hold on 
plot(temp/nSubj)
plot(ones(numtrials,1) * out.p.range)
hold off

t = sprintf('Performance against time, average across %d models', nSubj);
title(t, 'fontsize', FONTSIZE)
xlabel('epochs', 'fontsize', FONTSIZE);
ylabel('steps used', 'fontsize', FONTSIZE);
mylegend = legend('number of steps used',...
    'number of spots in the world');
set(mylegend,'FontSize',FONTSIZE);





