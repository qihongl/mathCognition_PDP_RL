function initPlot()
% Set up for the plot 
global d
%% set up the figure
d.fh = figure();
d.fh.WindowStyle = 'docked';
d.rax = subplot(3,1,1);
d.hax = subplot(3,1,2);
d.wax = subplot(3,1,3);
% d.dtimes = 2.^(10:10);

% % plot
axes(d.hax); cla;
axes(d.rax); cla;
end

