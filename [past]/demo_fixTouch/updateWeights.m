% written by professor Jay McClelland
function [ ] = updateWeights( )

global a w p;
% change in weights equals input times reward prediction error
if w.rS.handPos == w.rS.targPos
    aRwd = 1; %was Rwd  actual reward
% else
%     Rwd = max(a.wts*w.vS.visInput');
end
eRwd = max(a.wts*w.vS.visInput');
a.Rwd = aRwd;
a.dfRwd = (aRwd+eRwd)*p.gamma^w.rS.td; %this modulates the actual reward by the delay - not clear if this is optimal!
% isize = min(abs(a.dfRwd - a.act(a.choice)),.01);
% isign = sign(a.dfRwd - a.act(a.choice));
% inc = p.lrate*isize*isign;
inc = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;
end

