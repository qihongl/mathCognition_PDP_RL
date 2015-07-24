%% Evaluative the development of the model
clear all; 
%% construct the path to the data files
PATH.ROOT = '/Users/Qihong/Dropbox/github/mathCognition/';
PATH.DIR = 'sim08_moreSim/';
% PATH.DATA = 'data/record_noteach.mat';
PATH.DATA = 'record.mat';

%% load the data
load([PATH.ROOT PATH.DIR PATH.DATA], 'record')
fprintf('Testing the model from "%s"\n', PATH.DIR);
global p;
p = record.p;

%% Plot the steps used to finish the task
FONTSIZE = 12;
WHITE_SPACE = 5;
MAX_ITER = p.maxIter; 
finishedIdx = record.steps ~= MAX_ITER;

% plot steps used for completed trials
subplot(2,1,1)
plot(record.steps(finishedIdx)); 
xlim([0, length(record.steps(finishedIdx))]);
ylim([0,p.maxIter + WHITE_SPACE]);
title('Excluding incomplete trials', 'fontsize', FONTSIZE);
xlabel('Epoch', 'fontsize', FONTSIZE);
ylabel('Steps used', 'fontsize', FONTSIZE)
subplot(2,1,2)

% plot steps used for all trials
plot(record.steps)
xlim([0,p.runs]); ylim([0,p.maxIter + WHITE_SPACE])
title('All trials', 'fontsize', FONTSIZE);
xlabel('Epoch', 'fontsize', FONTSIZE);
ylabel('Steps used', 'fontsize', FONTSIZE)


% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 
% 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% 
% text(0.5, 0.99,'\bf 5000 epochs','HorizontalAlignment' ... 
%     ,'center','VerticalAlignment', 'top', 'fontsize', FONTSIZE)

% close all; 
%% Plot the performance on using correct order 
% get order data
% finishedData = record.indices(finishedIdx);
% order = cell(1, size(finishedData,2));
% for i = 1 : size(finishedData,2)
%     order{i} = getOrder(finishedData{i});
% end
% 
% % 
% temp = nan(size(order));
% for i = 1 : size(order,2)
%     temp(i) = ismonotonic(order{i});
% end