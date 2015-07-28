function [ ] = plotStepsUsed( record )
%% Plot the steps used to finish the task
% initialization 
global p plots;
p = record.p;

% get indices for trials that were finished
finishedIdx = record.steps ~= p.maxIter;

% plot steps used for all trials
axes(plots.stepsUsedAll)
plot(record.steps)
xlim([0,p.runs]); ylim([0,p.maxIter + plots.WHITE_SPACE])
title('Steps Used - All trials', 'fontsize', plots.FONTSIZE);
xlabel('Epoch', 'fontsize', plots.FONTSIZE);
ylabel('Steps', 'fontsize', plots.FONTSIZE)

% plot steps used for completed trials
axes(plots.stepsUsedCompleted)
plot(record.steps(finishedIdx)); 
xlim([0, length(record.steps(finishedIdx))]);
ylim([0,p.maxIter + plots.WHITE_SPACE]);
title('Steps Used - Excluding incomplete trials', 'fontsize', plots.FONTSIZE);
xlabel('Epoch', 'fontsize', plots.FONTSIZE);
ylabel('Steps', 'fontsize', plots.FONTSIZE)


% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 
% 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% 
% text(0.5, 0.99,'\bf 5000 epochs','HorizontalAlignment' ... 
%     ,'center','VerticalAlignment', 'top', 'fontsize', plots.FONTSIZE)

% close all; 
end

