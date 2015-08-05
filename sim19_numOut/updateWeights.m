% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
a.curRwd = computeRwd();
expRwd = max(a.aAct);
%% assign the reward values
a.dfRwd = a.curRwd + expRwd * p.gamma;

%% update the weights - back prop
% delta for all unit
delta3 = a.dfRwd - a.aAct(a.choice); 
delta2 = a.wts_HA(a.choice, :)' * delta3 .* (a.hAct .* (1-a.hAct));
% compute the changes for the weights
wtsHA_change = delta3 * a.hAct';
wtsVH_change = delta2 * w.vS.oldInput;
% update the weights
a.wts_HA(a.choice,:) = a.wts_HA(a.choice,:) + p.lrate * wtsHA_change;
a.wts_VH = a.wts_VH + p.lrate * wtsVH_change;

%% start over if an incorrect action was made
if p.teachingModeOn && ~w.actionCorrect
    w.tryAgain = true;
end

end