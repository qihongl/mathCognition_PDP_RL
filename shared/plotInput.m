function [  ] = plotInput()
global w

clf;
figure(1)
subplot(2,1,1)
plotInput_sup(w.input_old)
subplot(2,1,2)
plotInput_sup(w.input_cur)

end

function [] = plotInput_sup(input)
global p
visInput = input(1:p.eyeRange);
sensoryInput = input(p.eyeRange+1:end);
if length(visInput) ~= length(sensoryInput)
    error();
end

% plot inputs 
hold on
plot(visInput, 'linewidth', 2)
plot(sensoryInput, '--', 'linewidth', 2)
hold off
legend({'visual', 'touch'}, 'fontsize', 14)

% x,y lims 
xlim([1 p.eyeRange])
if max(input) > 0
    ylim([0 max(input)])
end

% x tick labels 
ax = gca;
ax.XTick = [1: p.eyeRange];
xtk_label = cell(p.eyeRange,1);
for i = 1 : p.eyeRange
    xtk_label{i} = num2str(i - p.eyeRad - 1);
end
ax.XTickLabel = xtk_label;

end