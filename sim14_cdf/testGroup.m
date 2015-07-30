function [] = testGroup(nSubj, epoch)
%testGroup Run N models, to establish sample size
if nargin == 0
    epoch = 5;
    nSubj = 10; 
end

%% create a new directory to save the results
index = 0;
dirName = sprintf('%s%.2d','groupResults', index);
% if directory already exists, use a new name 
while exist(dirName, 'dir') == 7
    index = index + 1;
    dirName = sprintf('%s%.2d','groupResults', index);
end
mkdir(dirName)

%% run the group analysis  
for i = 1:nSubj
    record = trainAgent(epoch);
    filename = sprintf('record%.2d', i);
    save([dirName '/'  filename],'record');
end
% beep % notice me that the program was ended
end

