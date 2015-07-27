% written by professor Jay McClelland
function [ ] = showState( )
global p w d a;
% plot rewards over time 
axes(d.rax);
plot(w.rS.time,a.Rwd,'-*'); hold on;
ylim(d.rax,[p.r.midNeg p.r.bigPos]); 
xlim(d.rax,[-0.25,w.rS.time+0.25]);

% plot the history of eye and hand positions
t = w.rS.time;
axes(d.hax);
plot(d.hax,[-p.spRad p.spRad],[t t]); hold on;
ylim(d.hax,[-0.25 t + .25]);
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

% plot weights
axes(d.wax);
plot(-p.mvRad:p.mvRad,a.wts);
end

