clf

LW = 3;
FS = 20;
hold on 
plot(w.vS.visInput, 'linewidth', LW)
plot(16,0, '*', 'linewidth', 10)
hold off 

% legend({'Activation', 'Fovea'}, 'fontsize', FS, 'location', 'SW', 'fontweight', 'bold')

xlim([1 31])
ylim([0 1.2])

% x tick labels 
ax = gca;
ax.XTick = [1: p.eyeRange];
xtk_label = cell(p.eyeRange,1);
for i = 1 : p.eyeRange
    xtk_label{i} = num2str(i - p.eyeRad - 1);
end
ax.XTickLabel = xtk_label;


set(gca,'FontSize',FS-6)
set(gca,'YTickLabel',[]);

