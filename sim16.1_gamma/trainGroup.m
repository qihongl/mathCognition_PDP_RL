function [] = trainGroup(nSubj, epoch)
%testGroup Run N models, to establish sample size
global p;
%% set the parameter that you want to vary 
gamma = 0.8 :0.025: 1;
for i = 1 : length(gamma)
    p.gamma = gamma(i);
    if nargin == 0
        epoch = 5000;
        nSubj = 5;
    end
    
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

