clear all;
%% Analyze the effect of gamma value 
dirName = 'groupData';
path = '/Users/Qihong/Dropbox/github/mathCognition/sim16.1_gamma/';
filename = 'groupScores';
initialGammaVal = 0.8;
increment = 0.025; 
numItems = 7; 
numSub = 5;
% loop over all data dir
for i = 0 : 8
    dataDir = sprintf('%s%.2d', dirName, i);
    datapath = [path dataDir];
    load([datapath '/' filename])

    % loop over all "subjects"
    for n = 1 : length(groupScores)
        dataVec = initialGammaVal + increment * i; 
        % overall data
        dataVec = [dataVec groupScores{n}.overall.meanSteps];
        dataVec = [dataVec groupScores{n}.overall.monotonicRate];
        dataVec = [dataVec groupScores{n}.overall.completeRate];
        dataVec = [dataVec groupScores{n}.overall.numCorrectCompleted];
        dataVec = [dataVec groupScores{n}.overall.skipRate];
        % by cardinality 
        dataVec = [dataVec groupScores{n}.byCard.meanSteps'];
        dataVec = [dataVec groupScores{n}.byCard.compRate'];
        dataVec = [dataVec groupScores{n}.byCard.correctCompRate'];
%         % check the length of the data 
%         if length(dataVec) ~= 12
%             error('nani!?')
%         end
        dataMatrix(numSub * i + n,:) = dataVec;
    end
end

% save the data
csvwrite('gammaData.csv',dataMatrix)
