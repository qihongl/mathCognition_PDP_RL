function initPlot()
% Set up for the plot 
global d
%% set up the figure
d.fh = figure();
d.fh.WindowStyle = 'docked';
% name of the plots
d.rwd = subplot(3,3,[1,2]);
d.history = subplot(3,3,[3,6,9]);
d.wts_VH = subplot(3,3,4);
d.wts_HA = subplot(3,3,5);
d.wts_NH = subplot(3,3,7);
d.wts_HN = subplot(3,3,8);

% plot
axes(d.history); cla;
axes(d.rwd); cla;
end

