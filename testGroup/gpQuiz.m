%% Test a group of models, in order to establish average performance
clear all; clear global; 

%% Get data from the current directory 
dataDir = {'groupData00'};
name = 'record';
nGroups = length(dataDir);
nSubj = 10; 
numQs = 500;

datapath = [pwd '/' dataDir{1} '/'];
addpath(pwd);


%% Single subject analysis 
% loop over all directories 
filenames = getFilenames(name, nSubj);
groupScores = cell(1, nSubj);
for n = 1 : nSubj
    % load the record for all subjects 
    fullPath = [datapath filenames{n}];
    load(fullPath, 'record');
    loadParams(record);
    % do single subject analysis and save the results 
    scores = askQuesitons(numQs, false);
    groupScores{n} = evaluateModel(scores, numQs);
    clear global; 
end
rmpath(pwd);

%% Group analysis 

%% save the results
saveFileName = sprintf('%sgroupScores' ,datapath);
save(saveFileName,'groupScores');

beep;