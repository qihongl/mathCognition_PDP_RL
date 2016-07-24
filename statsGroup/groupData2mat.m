clear all;
%% Analyze the effect of different parameters

% set parameters corrospondingly
path = '/Users/Qihong/Dropbox/github/mathCognition/';
dataDirName = 'groupData';
filename = 'groupScores.mat';

% simName = 'sim21.1_hiddenUnits';
% subSimName = 'ep20000';
simName = 'sim21.2_targetNet';
subSimName = 'ep2000_freq500';
saveFileName = 'targ00';


path = fullfile(path,simName,dataDirName,subSimName);
numItems = 7; 
numSub = 20;


%% start gathering data
dirNames = getAllDirNames(path);
% loop over all data dir
for i = 1:length(dirNames)
    datapath = fullfile(path, dirNames(i).name, filename);
    load(datapath)

    % loop over all "subjects"
    for n = 1 : length(groupScores)
        
        fieldsRemoved = {'meanNumSkips', 'meanNumSkips2','meanNumErrors'};
        groupScores{n}.overall = rmfield(groupScores{n}.overall,fieldsRemoved);
        fieldNames.overall = fieldnames(groupScores{n}.overall);
        
        fieldsRemoved = {'meanNumSkips', 'meanNumSkips2','monotonicRate'};
        groupScores{n}.byCard = rmfield(groupScores{n}.byCard,fieldsRemoved);
        fieldNames.byCard = fieldnames(groupScores{n}.byCard);

        dataVec = i; 
        % overall data
        dataVec = [dataVec groupScores{n}.overall.meanSteps];
        dataVec = [dataVec groupScores{n}.overall.monotonicRate];
        dataVec = [dataVec groupScores{n}.overall.skipRate];
        dataVec = [dataVec groupScores{n}.overall.meanNumDoubleTouch];
        dataVec = [dataVec groupScores{n}.overall.completeRate];
        
        dataVec = [dataVec groupScores{n}.overall.correctCompRate];
        dataVec = [dataVec groupScores{n}.overall.stopEarlyRate];
        
        
        % by cardinality 
        dataVec = [dataVec groupScores{n}.byCard.meanSteps'];
        dataVec = [dataVec groupScores{n}.byCard.compRate'];
        dataVec = [dataVec groupScores{n}.byCard.correctCompRate'];
        dataVec = [dataVec groupScores{n}.byCard.skipRate'];        
        dataVec = [dataVec groupScores{n}.byCard.meanNumDoubleTouch'];
        
        dataVec = [dataVec groupScores{n}.byCard.meanNumErrors'];
        dataVec = [dataVec groupScores{n}.byCard.stopEarlyRate'];        
        
        % add the vector into a data matrix
        dataMatrix(numSub * (i-1) + n,:) = dataVec;
    end
end

%% save the data
data.numItems = numItems;
data.numSubj = numSub;
data.path = path; 
data.name = saveFileName;
data.matrix = dataMatrix;
data.columLabels = fieldNames;

% csvwrite(strcat(saveFileName,'.csv'),dataMatrix)
save(fullfile(path,saveFileName),'data');
