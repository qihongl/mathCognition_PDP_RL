%% groupAnalysis
clear all; clear global;

dirName = 'groupData';
% name = 'record';
numDir = 3;
nSubj = 10;

quizDataName = 'groupScores';
deveDataName = 'pooledScore';

%% Construct datapath
% generate directory names
dataDir = cell(numDir, 1);
for i = 0 : numDir - 1
    dataDir{i + 1} = sprintf('%s%.2d', dirName, i);
end
% % generate file names
% filenames =  cell(nSubj, 1);
% for i = 1 : nSubj
%     filenames{i} = sprintf('%s%.2d', name, i);
% end

%% Do the analysis for all data and save the results
%% Quiz data
gp.meanSteps = nan(nSubj, 1);
gp.monotonRate = nan(nSubj, 1);
gp.compRate = nan(nSubj, 1);
gp.skipRate = nan(nSubj, 1);

for i = 1 : numDir
    % load quiz group data
    fullpath = [dataDir{i} '/' quizDataName];
    load(fullpath);
    % get data for all subjects
    for n = 1 : nSubj
        gp.meanSteps(n) = groupScores{n}.meanSteps;
        gp.monotonRate(n) = groupScores{n}.monotonicRate;
        gp.compRate(n) = groupScores{n}.completeRate;
        gp.skipRate(n) = groupScores{n}.skipRate;
    end
    % convert it into a matrix 
    outFile = [gp.meanSteps gp.monotonRate gp.compRate gp.skipRate];
    outPath = [pwd '/' dataDir{i} '/'];
    % save as a .csv file
    csvwrite([outPath 'groupData.csv'], outFile);
end

%% Developmental data
for i = 1 : numDir
    % load developmental group data
    fullpath = [dataDir{i} '/' deveDataName];
    load(fullpath);
end

