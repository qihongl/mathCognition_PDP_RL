% written by professor Jay McClelland
function [ ] = showState( )
global p w d a;
% plot current and expected rewards over time 
axes(d.rwd);
plot(w.rS.time,a.Rwd,'-b*'); hold on;
plot(w.rS.time,a.dfRwd,'-r*');
legend({'current reward', 'discounted future reward'},...
    'Location','northwest', 'fontsize', d.FONTSIZE)

ylim(d.rwd,[p.r.midNeg p.r.bigPos]); 
xlim(d.rwd,[-0.25,w.rS.time+0.25]);
title(d.rwd, 'Reward history', 'fontsize', d.FONTSIZE)
xlabel(d.rwd, 'Time', 'fontsize', d.FONTSIZE)
ylabel(d.rwd, 'Current Reward value', 'fontsize', d.FONTSIZE)

% plot the history of eye and hand positions
t = w.rS.time;
axes(d.history);
plot(d.history,[-p.spRad p.spRad],[t t]); hold on;
ylim(d.history,[-0.25 t + .25]);
if w.done
    text(w.rS.handPos,t,'o','HorizontalAlignment','center');
else
    text(w.rS.eyePos,t,'@','HorizontalAlignment','center');
    text(w.rS.handPos,t,'#','HorizontalAlignment','center');
end

for i = 1 : w.nItems
    if w.rS.targRemain(i)
        symbol = 'X';
    else
        symbol = '|';
    end
    text(w.rS.targPos(i),t,symbol,'HorizontalAlignment','center');
end

title(d.history, 'Action history', 'fontsize', d.FONTSIZE)
xlabel(d.history, 'Position', 'fontsize', d.FONTSIZE)
ylabel(d.history, 'Time', 'fontsize', d.FONTSIZE)


end

