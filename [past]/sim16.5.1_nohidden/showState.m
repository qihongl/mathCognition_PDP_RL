% written by professor Jay McClelland
function [ ] = showState( )

global p w d a;

%% plot current and expected rewards over time
axes(d.rwd);
plot(w.rS.time,a.curRwd,'-b*'); hold on;
plot(w.rS.time,a.expRwd,'-r*');
legend({'current reward', 'esimtated reward'},...
    'Location','northwest', 'fontsize', d.FONTSIZE)

% extend the y range if needed
if a.expRwd > d.rwdUpper
    d.rwdUpper = a.expRwd;
elseif a.expRwd < d.rwdLower
    d.rwdLower = a.expRwd;
end
ylim(d.rwd,[floor(d.rwdLower) ceil(d.rwdUpper)]);

% add labels
xlim(d.rwd,[-0.25,w.rS.time+0.25]);
title(d.rwd, 'Reward history', 'fontsize', d.FONTSIZE)
xlabel(d.rwd, 'Time', 'fontsize', d.FONTSIZE)
ylabel(d.rwd, 'Current Reward value', 'fontsize', d.FONTSIZE)

%% plot the history of eye and hand positions
t = w.rS.time;
axes(d.actionHistory);
plot(d.actionHistory,[-p.spRad p.spRad],[t t]); hold on;
ylim(d.actionHistory,[-0.25 t + .25]);
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

for i = 1 : w.nItems
    if w.rS.targRemain(i)
        symbol = 'x';
    else
        symbol = '|';
    end
    text(w.vS.targPos(i) + w.rS.eyePos,t, symbol,'HorizontalAlignment','center','color','red');
end

title(d.actionHistory, 'Action history', 'fontsize', d.FONTSIZE)
xlabel(d.actionHistory, 'Position', 'fontsize', d.FONTSIZE)
ylabel(d.actionHistory, 'Time', 'fontsize', d.FONTSIZE)


%% plot all weights
axes(d.visInpHistory);
col = autumn;
col = flipud(col);
intensityVal = floor(w.vS.visInput * size(col,1));
hold on
for i = 1: length(w.vS.visInput)
    if intensityVal(i) == 0
        plot(i,t);
    else
        plot(i,t,'-*', 'color',col(intensityVal(i),:));
    end
end
text(p.eyeRad+1,t,'@');
hold off


% plot(w.vS.visInput)
% plot([-p.eyeRad:p.eyeRad],w.vS.visInput);
title(d.visInpHistory, 'Visual input across time', 'fontsize', d.FONTSIZE)
xlabel(d.visInpHistory, 'Visual input pattern', 'fontsize', d.FONTSIZE)
ylabel(d.visInpHistory, 'Time', 'fontsize', d.FONTSIZE)

end

