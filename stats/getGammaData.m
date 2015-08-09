clear all;
%% Analyze the effect of gamma value 
dirName = 'groupData';
path = '/Users/Qihong/Dropbox/github/mathCognition/sim16.1_gamma/';
filename = 'groupScores';
initialGammaVal = 0.6;
increment = 0.05; 
numItems = 7; 
numSub = 5;
% loop over all data dir
for i = 0 : 8
    dataDir = sprintf('%s%.2d', dirName, i);
    datapath = [path dataDir];
    load([datapath '/' filename])
    
    initialGammaVal = 0.6;
    % loop over all "subjects"
    for n = 1 : length(groupScores)
        
        dataVec = initialGammaVal + increment * i; 
        dataVec = [dataVec groupScores{n}.meanSteps];
        dataVec = [dataVec groupScores{n}.monotonicRate];
        dataVec = [dataVec groupScores{n}.completeRate];
        dataVec = [dataVec groupScores{n}.skipRate];
        dataVec = [dataVec groupScores{n}.stepsByCard];
        if length(dataVec) ~= 12
            error('nani!?')
        end
        dataMatrix(numSub * i + n,:) = dataVec;
    end
end

% save the data
% csvwrite('gammaData.csv',dataMatrix)
