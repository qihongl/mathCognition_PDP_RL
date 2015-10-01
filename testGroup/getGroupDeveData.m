%% Test a group of models, in order to establish average performance
clear all; clear global; clc;

%% Get data from the current directory
numQs = 20;
name = 'record';
dirName = 'groupData';

for i = 1:3
    % get access to the right data directory 
    dataDir = sprintf('%s%.2d',dirName, i);
    datapath = [pwd '/' dataDir '/'];
    nSubj = getNumRecords(datapath);  
    
    addpath(pwd);
    %% Single subject analysis
    % loop over all directories
    filenames = getFilenames(name, nSubj);
    for n = 1 : nSubj
        % load the record for all subjects
        fullPath = [datapath filenames{n}];
        load(fullPath, 'record');
        
        % loop over all developmental intervals
        numWeights = record.p.runs/record.p.saveWtsInterval + 1;
        for developEpisode = 1 : numWeights
            fprintf('Subject %d \t Develop stage: %d\n', n, developEpisode);
            loadParam_development(record, developEpisode);
            % do single subject analysis and save the results
            scores = askQuesitons(numQs, false);
            groupDeveScores{n,developEpisode} = evaluateModel_quiz(scores, numQs, false);
        end
    end
    rmpath(pwd);
    
    %% save the results
    saveFileName = sprintf('%sgroupDeveScores' ,datapath);
    save(saveFileName,'groupDeveScores');
    
end
beep;
