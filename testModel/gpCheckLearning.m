%% Check the learning curve of a group of models, get average performance
clear all; clear global; 
%% Get data from the current directory 
dataDir = {'groupData00'};
name = 'record';
nGroups = length(dataDir);
nSubj = 10; 
LENGTH = 100; 
datapath = [pwd '/' dataDir{1} '/'];

%% Single subject analysis 
% loop over all directories 
pooledScore = cell(1, nSubj);
filenames = getFilenames(name, nSubj);
for n = 1 : nSubj
    % load the record for all subjects 
    fullPath = [datapath filenames{n}];
    load(fullPath, 'record');
    % get performance evaluation by period
    pooledScore{n} = getPooledScores(record, LENGTH);
end


%% save the results
saveFileName = sprintf('%spooledScore' ,datapath);
save(saveFileName,'pooledScore');