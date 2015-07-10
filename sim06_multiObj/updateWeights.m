% written by professor Jay McClelland
function [ ] = updateWeights( )

global a w p;
% give reward if touched the item
if w.rS.handPos == w.rS.targPos
    Rwd = 2;
else
    Rwd = max(a.wts*w.vS.visInput');
%     Rwd = 0;
end

a.Rwd = Rwd;
a.dfRwd = Rwd*p.gamma^w.rS.td;

% change in weights equals input times reward prediction error
inc = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;
end

