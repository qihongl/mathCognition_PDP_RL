% written by professor Jay McClelland
function [ ] = showState( )
global p w d a;
% plot rewards over time 
axes(d.rwdAx);
plot(w.rS.time,a.Rwd,'-*'); hold on;
ylim(d.rwdAx,[p.r.bigNeg p.r.bigPos]); 
xlim(d.rwdAx,[-0.25,w.rS.time+0.25]);

% plot the history of eye and hand positions
t = w.rS.time;
axes(d.historyAx);
plot(d.historyAx,[-p.spRad p.spRad],[t t]); hold on;
ylim(d.historyAx,[-0.25 t + .25]);
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

% plot all weights
axes(d.allWeightsAx);
plot(-p.eyeRad:p.eyeRad,a.wts);
legend_str = num2str((1:size(a.wts,1))');
legend(legend_str,'location','NorthWest')

% plot weights around fovea
axes(d.someWeightsAx)
midIdx = (p.eyeRad - 5) : (p.eyeRad + 5);
legend_str = num2str(midIdx');
plot(a.wts(:,midIdx))
legend(legend_str,'location','NorthWest')
end

