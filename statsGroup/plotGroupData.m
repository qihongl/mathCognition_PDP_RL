clear all; clf
%% Analyze the effect of different parameters
% these three path info should be fixed ...
path = '/Users/Qihong/Dropbox/github/mathCognition/';
dataDirName = 'groupData';
filename = 'groupScores.mat';

% set parameters corrospondingly
simName = 'sim21.1_hiddenUnits';
subSimName = 'ep20000';
saveFileName = 'hidden00';

% used as legend later
% TODO, read the label automatically
condition.labels = {...
    'ep20000'
%     'ep 5000, bs 2',...
%     'ep 5000, bs 16',...
%     'ep 5000, bs 32',...
    %     'ep 5000, replay OFF',...
    %     'ep 10000, replay OFF',...
    };

condition.mask = [];
criterionMask = [2 6];

%% load data
path = fullfile(path,simName,dataDirName,subSimName);
load(fullfile(path, saveFileName))
% check the number of conditions used
condition.num = length(unique(data.matrix(:,1)));
[col, numSubj, numItems, dataMatrix] = procInput(condition, data);

% index for the rates
rateLabels = col.labels.byCard([2 3 4 5 7]);

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
alpha = .975;


startIdx = 1 + col.num.overall;
% loop over all measured performance metrics
for i = 1 : length(col.labels.byCard)
    % mask out some performance metrics
    if ismember(i,criterionMask)
        continue;
    end
    lab = col.labels.byCard{i};
    tempIdx = startIdx + (1 + (i-1) * numItems : (i * numItems));
    
    % dynamically size the subplot panel to 2 X N
    subplot(2,ceil((length(col.labels.byCard)-length(criterionMask))/2), i-sum(i > criterionMask))
    % loop over all simulation conditions
    hold on
    for n = 1: length(dataByCond)
        % mask out some conditions
        if ismember(n,condition.mask)
            continue;
        end
        % compute summary statistics
        dataHolder = dataByCond{n};
        meanScore = mean(dataHolder(:,tempIdx));
        seScore = std(dataHolder(:,tempIdx)) / sqrt(numSubj);
        
        % plot the data
        errorbar(1:numItems,meanScore,seScore * tinv(alpha, numSubj-1), 'linewidth', p.LW)
        
        % add text
        xlim([1,numItems])
        ylabel(lab,'fontsize',p.FS)
        xlabel('Number of objects presented','fontsize',p.FS)
        
        if ismember(col.labels.byCard{i},rateLabels )
            ylim([0 1])
        end
    end
    hold off
    
end
% mask our the legend;
condition.labels(condition.mask) = [];
legend(condition.labels,'fontsize',p.FS)
% suptitle_text = sprintf('simulationName: %s  Intermediate reward + teacher demonstration \n varying training epochs and replay batch size', subSimName);
suptitle_text = sprintf('simulationName: %s  Intermediate reward + teacher demonstration\n with hidden units', subSimName);
suptitle(suptitle_text)


figure(gcf);
set(gcf,'renderer','opengl');