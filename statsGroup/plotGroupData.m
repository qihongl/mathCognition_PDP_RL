clear all; clf
%% Analyze the effect of different parameters
% these three path info should be fixed ...
path = '/Users/Qihong/Dropbox/github/mathCognition/';
dataDirName = 'groupData';
filename = 'groupScores.mat';

% set parameters corrospondingly
simName = 'sim21.0_replay';
subSimName = 'epoch500';
saveFileName = 'replay01';

% used as legend later
% TODO, read the label automatically
condition.labels = {...
    'ep 500, bs 5',...
    'ep 500, bs 10',...
    'ep 500, bs 30',...
    'ep 5000, replay OFF',...
    'ep 10000, replay OFF',...
    };

condition.mask = [3 4];
criterionMask = [2 6];

%% load data
path = fullfile(path,simName,dataDirName,subSimName);
load(fullfile(path, saveFileName))
% check the number of conditions used
condition.num = length(unique(data.matrix(:,1)));
[col, numSubj, numItems, dataMatrix] = procInput(condition, data);
clear data;
%% read data

dataByCond = cell(condition.num,1);

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
% loop over all measured performance metrics
for i = 1 : length(col.labels.byCard)
    % mask out some performance metrics
    if ismember(i,criterionMask)
        continue;
    end
    lab = col.labels.byCard{i};
    tempIdx = startIdx + (1 + (i-1) * numItems : (i * numItems));
    
    
    % loop over all simulation conditions
    subplot(2,round((length(col.labels.byCard) - length(criterionMask))/2),i-sum(i > criterionMask))
    hold on
    for n = 1: length(dataByCond)
        % mask out some conditions
        if ismember(n,condition.mask)
            continue;
        end
        % plot the data
        dataHolder = dataByCond{n};
        meanScore = mean(dataHolder(:,tempIdx));
        seScore = std(dataHolder(:,tempIdx)) / sqrt(numSubj);
        errorbar(1:numItems,meanScore,seScore * tinv(.975, numSubj-1), 'linewidth', p.LW)
        %         plot(meanScore, 'linewidth', p.LW)
        xlim([1,7])
        ylabel(lab,'fontsize',p.FS)
        xlabel('Number of objects presented','fontsize',p.FS)
    end
    hold off
    
end
% mask our the legend;
condition.labels(condition.mask) = [];
legend(condition.labels,'fontsize',p.FS)
suptitle_text = sprintf('Intermediate reward + teacher demonstration \n varying training epochs and replay batch size');
suptitle(suptitle_text)
