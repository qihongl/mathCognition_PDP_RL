clear all; clf 
%% Analyze the effect of different parameters
% these three path info should be fixed ... 
path = '/Users/Qihong/Dropbox/github/mathCognition/';
dataDirName = 'groupData';
filename = 'groupScores.mat';

% set parameters corrospondingly
simName = 'sim21.0_replay';
subSimName = 'combinedMode';
saveFileName = 'replay00';

% max number of objects & sim sample size
numItems = 7; 
numSub = 20;

% used as legend later 
% TODO, read the label automatically 
condition.labels = {'ep 5000, batchSize 1','ep 5000, batchSize 2','ep 5000, batchSize 16',...
    'ep 10000','ep 5000','ep 500 batchSize 20'};

%% load data 
path = fullfile(path,simName,dataDirName,subSimName);
load(fullfile(path, saveFileName))
% check the number of conditions used 
condition.num = length(unique(data.matrix(:,1)));
[col, numSubj, numItems, dataMatrix] = procInput(condition, data);
clear data; 
%% read data 

dataByCond = cell(6,1);

for n = 1 : condition.num
    % the row for each condition, each row represents a subject 
    rowIdx = 1 + (n-1) * numSubj : n * numSubj;
    dataByCond{n} = dataMatrix(rowIdx,:);
    
    % compute summary statistics 
    mean(dataByCond{n});
    std(dataByCond{n});
    
end

%% plot: by card 
p.FS = 14;
p.LW = 2; 


startIdx = 1 + col.num.overall;

for i = 1 : length(col.labels.byCard)
    lab = col.labels.byCard{i};
    tempIdx = startIdx + (1 + (i-1) * numItems : (i * numItems));
    
    subplot(2,4,i)
    hold on 
    for n = 1: length(dataByCond)
        dataHolder = dataByCond{n};
        meanScore = mean(dataHolder(:,tempIdx));
        plot(meanScore, 'linewidth', p.LW)
        xlim([1,7])
        ylabel(lab,'fontsize',p.FS)
        xlabel('Number of objects presented','fontsize',p.FS)
    end
    hold off 

end
legend(condition.labels,'fontsize',p.FS)
suptitle_text = sprintf('Intermediate reward + teacher demonstration \n varying training epochs and replay batch size');
suptitle(suptitle_text)






