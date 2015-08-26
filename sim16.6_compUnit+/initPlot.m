function initPlot()
% Set up for the plot 
global d
%% set up the figure
d.fh = figure();
d.fh.WindowStyle = 'docked';
% name of the plots
d.rwd = subplot(2,2,1);
d.actionHistory = subplot(2,2,2);
d.visInpHistory = subplot(2,2,3);
d.heatWts = subplot(2,2,4);

% constant
d.FONTSIZE = 14; 

% % plot
% axes(d.actionHistory); cla;
% axes(d.rwd); cla;
end

