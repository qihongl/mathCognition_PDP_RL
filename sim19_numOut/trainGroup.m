function [] = trainGroup(nSubj, epoch)
%testGroup Run N models, to establish sample size
if nargin == 0
    epoch = 5000;
    nSubj = 10; 
end

%% create a new directory to save the results
dirName = createDir('groupData');

%% run the group analysis  
for i = 1:nSubj
    record = trainAgent(epoch);
    filename = sprintf('record%.2d', i);
    save([dirName '/'  filename],'record');
end

beep
end

