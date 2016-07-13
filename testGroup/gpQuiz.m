%% Test a group of models, in order to establish average performance
clear all; clear global;

%% Get data from the current directory
projPath = '/Users/Qihong/Dropbox/github/mathCognition/';
datadir = 'groupData';
filename = 'groupScores';
% set parameters corrospondingly
simName = 'sim21.0_replay';
subSimName = 'combinedMode';
path = fullfile(projPath, simName, datadir,subSimName);

% 
nSubj = 20;
numQs = 100;
name = 'record';
option = {'runAllDir', 'runSelectedDir'};
dirNames = getAllDirNames(path);

for i = 1: length(dirNames)
    % get access to the right data directory 
    finalpath = fullfile(path,dirNames(i).name);
    addpath(fullfile(projPath,simName));
    
    %% Single subject analysis
    % loop over all directories
    filenames = getFilenames(name, nSubj);
    groupScores = cell(1, nSubj);
    for n = 1 : nSubj
        % load the record for all subjects
        load(fullfile(finalpath, filenames{n}), 'record');
        loadParams(record);
        % do single subject analysis and save the results
        scores = askQuesitons(numQs, false);
        groupScores{n} = evaluateModel_quiz(scores, numQs);
        clear global;
    end
    rmpath(fullfile(projPath,simName));
    
    %% save the results
    saveFileName = fullfile(finalpath,'groupScores.mat');
    save(saveFileName,'groupScores');
    
end
beep;
