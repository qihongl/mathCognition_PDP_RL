%% groupAnalysis
clear all; clear global;
% initialization
global p;
p.numDir = 3;
p.nSubj = 10;
path.dirName = 'groupData';
path.quizDataName = 'groupScores';
path.deveDataName = 'pooledScore';

%% Construct datapath
path.dataDir = cell(p.numDir, 1);
for i = 0 : p.numDir - 1
    path.dataDir{i + 1} = sprintf('%s%.2d', path.dirName, i);
end

%% Get Quiz data
gpData = processGroupQuiz(path);

%% Get Developmental data
deveData = processGroupDeve(path);
result = meanByCond_deve(deveData);
plot_meanByCond_deve(result);
