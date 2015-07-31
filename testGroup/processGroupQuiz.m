function [ gp ] = processGroupQuiz(path)
%% this function takes summarized data for each group, and save them
global p;
gp = cell(p.numDir,1);

% loop over all data dir
for i = 1 : p.numDir
    % preallocate resources
    gp{i}.meanSteps = nan(p.nSubj, 1);
    gp{i}.monotonRate = nan(p.nSubj, 1);
    gp{i}.compRate = nan(p.nSubj, 1);
    gp{i}.skipRate = nan(p.nSubj, 1);
    
    %% load quiz group data
    fullpath = [path.dataDir{i} '/' path.quizDataName];
    load(fullpath);
    
    %% get data for all subjects
    for n = 1 : p.nSubj
        gp{i}.meanSteps(n) = groupScores{n}.meanSteps;
        gp{i}.monotonRate(n) = groupScores{n}.monotonicRate;
        gp{i}.compRate(n) = groupScores{n}.completeRate;
        gp{i}.skipRate(n) = groupScores{n}.skipRate;
    end
    
    
    % convert it into a matrix
%     outFile = [gp{i}.meanSteps gp{i}.monotonRate gp{i}.compRate gp{i}.skipRate];
%     outPath = [pwd '/' path.dataDir{i} '/'];
    % save as a .csv file
    %     csvwrite([outPath 'groupData.csv'], outFile);
    
    
    %% TODO : get data by card 
end

end

