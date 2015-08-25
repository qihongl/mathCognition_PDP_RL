%% Test a group of models, in order to establish average performance
clear all; clear global;

%% Get data from the current directory

nSubj = 10;
numQs = 5;
nGroups = 3;
name = 'record';
dirName = 'groupData';

for i = 0 : nGroups
    % get access to the right data directory 
    dataDir = sprintf('%s%.2d',dirName, i);
    datapath = [pwd '/' dataDir '/'];
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
        groupScores{n} = evaluateModel_quiz(scores, numQs);
        clear global;
    end
    rmpath(pwd);
    
    %% save the results
    saveFileName = sprintf('%sgroupScores' ,datapath);
    save(saveFileName,'groupScores');
    
end
beep;
