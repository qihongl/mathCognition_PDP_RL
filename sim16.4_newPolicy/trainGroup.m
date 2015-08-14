function [] = trainGroup(nSubj, epoch)
%testGroup Run N models, to establish sample size
global p;
%% set the parameter that you want to vary
if nargin == 0
    epoch = 5000;
    nSubj = 10;
end

param = [0];
for i = 1 : length(param)
%     p.PFd = param(i); % varying parameter
    
    %% create a new directory to save the results
    dirName = createDir('groupData');
    
    %% run the group analysis
    for n = 1:nSubj
        record = trainAgent(epoch, n);
        filename = sprintf('record%.2d', n);
        save([dirName '/'  filename],'record');
    end
        
end

beep
end

