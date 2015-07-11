% written by professor Jay McClelland
function [ ] = updateWeights( )

global a w p;
% give reward if touched the item
if any(w.rS.handPos == w.rS.targPos) && (w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true)
    w.rS.targRemain(w.rS.targPos == w.rS.handPos) = false;
    Rwd = 1;
    if all(w.rS.targRemain == false)
        Rwd = 2;
        w.done = true;
    end
else
%     Rwd = max(a.wts*w.vS.visInput');
    Rwd = -0.01;
end

a.Rwd = Rwd;
a.dfRwd = Rwd*p.gamma^w.rS.td;

% change in weights equals input times reward prediction error
inc = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;
end

