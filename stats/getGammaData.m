clear all;
%% Analyze the effect of gamma value 
dirName = 'groupData';
path = '/Users/Qihong/Dropbox/github/mathCognition/sim16.3_compTeach/';
filename = 'groupScores';
teachingModel = [0 1 2 3 4 5];

numItems = 7; 
numSub = 10;
% loop over all data dir
for i = teachingModel
    dataDir = sprintf('%s%.2d', dirName, i);
    datapath = [path dataDir];
    load([datapath '/' filename])

    % loop over all "subjects"
    for n = 1 : length(groupScores)
        dataVec = teachingModel(i + 1); 
        % overall data
        dataVec = [dataVec groupScores{n}.overall.meanSteps];
        dataVec = [dataVec groupScores{n}.overall.monotonicRate];
        dataVec = [dataVec groupScores{n}.overall.completeRate];
        dataVec = [dataVec groupScores{n}.overall.correctCompRate];
        dataVec = [dataVec groupScores{n}.overall.skipRate];
        % by cardinality 
        dataVec = [dataVec groupScores{n}.byCard.meanSteps'];
        dataVec = [dataVec groupScores{n}.byCard.compRate'];
        dataVec = [dataVec groupScores{n}.byCard.correctCompRate'];
        % add the vector into a data matrix
        dataMatrix(numSub * i + n,:) = dataVec;
    end
end

% save the data
csvwrite('compTeach4.csv',dataMatrix)
