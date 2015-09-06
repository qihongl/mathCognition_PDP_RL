clear all;
%% Analyze the effect of different parameters

% set parameters corrospondingly
dirName = 'groupData';
path = '/Users/Qihong/Dropbox/github/mathCognition/sim20_perfect/';
filename = 'groupScores';
saveFileName = 'perfect.csv';

teachingModel = 0:3;
numItems = 7; 
numSub = 20;

%% start gathering data
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
        dataVec = [dataVec groupScores{n}.overall.stopEarlyRate];
        dataVec = [dataVec groupScores{n}.overall.meanNumDoubleTouch];
        
        % by cardinality 
        dataVec = [dataVec groupScores{n}.byCard.meanSteps'];
        dataVec = [dataVec groupScores{n}.byCard.compRate'];
        dataVec = [dataVec groupScores{n}.byCard.correctCompRate'];
        dataVec = [dataVec groupScores{n}.byCard.skipRate'];
        dataVec = [dataVec groupScores{n}.byCard.stopEarlyRate'];
        dataVec = [dataVec groupScores{n}.byCard.meanNumErrors'];
        dataVec = [dataVec groupScores{n}.byCard.meanNumDoubleTouch'];
        
        % add the vector into a data matrix
        dataMatrix(numSub * i + n,:) = dataVec;
    end
end

% save the data
csvwrite(saveFileName,dataMatrix)
