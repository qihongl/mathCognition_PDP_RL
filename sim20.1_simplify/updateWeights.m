% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
a.curRwd = computeRwd();
% if reward == -1, do sth diff
a.act_next = a.wts*w.vS.visInput';
a.act_next(p.mvRad + 1) = a.act_next(p.mvRad + 1) + a.bias;
a.expRwd = max(a.act_next);

% % there is no expected reward for the last step
if ~w.done
    a.dfRwd = a.curRwd + a.expRwd * p.gamma;
else
    a.dfRwd = a.curRwd;
end

%% update the weights
% change in weights equals input times reward prediction error
change = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + change * w.vS.oldInput;

end