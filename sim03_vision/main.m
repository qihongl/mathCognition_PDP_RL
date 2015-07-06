%% counting simulation
clear; clc % clear things up

% set simulation parameters
nSubj = 20;
numtrials = 100;

%% analysis
% averaging the data
temp = zeros(numtrials,1);
for i = 1 : nSubj
    out = touch(i + 1600, false);
    temp = temp + out.h.stepsUsed;
    
end
mean = temp/nSubj;


%% plot performance
FONTSIZE = 14;
% plot 
hold on 
plot(mean)
plot(ones(numtrials,1) * out.p.range)
hold off

% set range
ylim([0,   round(max(mean) + 3) ]);

% set labels
t = sprintf('Performance against time, average across %d models', nSubj);
title(t, 'fontsize', FONTSIZE)
xlabel('epochs', 'fontsize', FONTSIZE);
ylabel('steps used', 'fontsize', FONTSIZE);
baseline = sprintf('number of spots in the world (%d)', out.p.range);
mylegend = legend('number of steps used', baseline);
set(mylegend,'FontSize',FONTSIZE);





