% written by professor Jay McClelland
% not currently used - this version adds the actual reward and disc future
% reward rather than using the actual if obtained and disc future rwd
% otherwise
function [ ] = updateWeights( )

global a w p;
% change in weights equals input times reward prediction error
if w.rS.handPos == w.rS.targPos
    aRwd = 1; %was Rwd  actual reward
% else %TOOK NEXT LINE OUT of else
%     Rwd = max(a.wts*w.vS.visInput');
end
eRwd = max(a.wts*w.vS.visInput');
a.Rwd = aRwd; %was = Rwd
%next line is changed:
%This version modulates the actual reward by the delay - not clear if this is optimal!
a.dfRwd = (aRwd+eRwd)*p.gamma^w.rS.td;
% isize = min(abs(a.dfRwd - a.act(a.choice)),.01);
% isign = sign(a.dfRwd - a.act(a.choice));
% inc = p.lrate*isize*isign;
inc = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;
end

