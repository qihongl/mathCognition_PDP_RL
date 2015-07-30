function initPlot()
% Set up for the plot 
global d
%% set up the figure
d.fh = figure();
d.fh.WindowStyle = 'docked';
% name of the plots
d.rwd = subplot(2,2,1);
d.history = subplot(2,2,2);
d.allWeights = subplot(2,2,3);
d.heatMap = subplot(2,2,4);

% % plot
axes(d.historyAx); cla;
axes(d.rwdAx); cla;
end

