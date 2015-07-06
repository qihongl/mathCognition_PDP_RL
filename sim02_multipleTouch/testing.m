% set simulation parameters
nSubj = 10;
numtrials = 100;

%% analysis
% averaging the data

temp = zeros(numtrials,1);
for i = 1 : nSubj
    out = touch(i, false);
%     temp = temp + out.h.stepsUsed;
    
end


