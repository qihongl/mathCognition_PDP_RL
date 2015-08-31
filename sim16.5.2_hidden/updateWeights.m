% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
curRwd = computeRwd();
a.aAct_next = a.wts_HA*tanh(a.wts_VH * w.vS.visInput');
a.aAct_next(p.mvRad + 1) = a.aAct_next(p.mvRad + 1) + a.bias;
expRwd = max(a.aAct_next); 

% there is no expected reward for the last step
if ~w.done
    a.dfRwd = curRwd + expRwd * p.gamma;
else
    a.dfRwd = curRwd; 
end

%% update the weights - back prop
% compute delta the active action unit and hidden units
delta3 = a.dfRwd - a.aAct(a.choice); 
delta2 = a.wts_HA(a.choice, :)' * delta3 .* (1-(a.hAct.^2));

% compute the changes for the weights
wtsHA_change = delta3 * a.hAct';
wtsVH_change = delta2 * w.vS.oldInput;
% update the weights
a.wts_HA(a.choice,:) = a.wts_HA(a.choice,:) + p.lrate * wtsHA_change;
a.wts_VH = a.wts_VH + p.lrate * wtsVH_change;
end
