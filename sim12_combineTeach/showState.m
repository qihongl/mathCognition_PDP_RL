% written by professor Jay McClelland
function [ ] = showState( )
global p w d a;
% plot rewards over time 
axes(d.rax);
% if a.Rwd == p.r.smallNeg 
%     color = 'c';
% elseif a.Rwd == p.r.midNeg || a.Rwd == p.r.bigNeg
%     color = 'b';
% elseif a.Rwd == p.r.midPos
%     color = 'y';
% elseif a.Rwd == p.r.bigPos
%     color = 'r';
% else
%     color = 'k';
% end 

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
plot(-p.spRad:p.spRad,a.wts);
end

