function [  ] = plotInput( input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global p

clf;

visInput = input(1:p.eyeRange);
sensoryInput = input(p.eyeRange:end);

hold on
plot(visInput, 'linewidth', 2)
plot(sensoryInput, '--', 'linewidth', 2)
hold off

legend({'visual', 'touch'}, 'fontsize', 14)

xlim([1 p.eyeRange])
if max(input) > 0
    ylim([0 max(input)])
end
% set(gca,'xtick',-p.eyeRad:1:p.eyeRad)
ax = gca;
ax.XTick = [1: p.eyeRange];
% ax.XTickLabel = {'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi'};

xtk_label = cell(p.eyeRange,1);

for i = 1 : p.eyeRange
    xtk_label{i} = num2str(i - p.eyeRad - 1);
end
ax.XTickLabel = xtk_label;
end