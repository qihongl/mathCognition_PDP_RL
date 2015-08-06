% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
a.aCurRwd = computeRwdA();
aExpRwd = max(a.aAct); 
nExpRwd = max(a.nOutAct); 
% sum current reward and future reward 
a.aDfRwd = a.aCurRwd + aExpRwd * p.gamma;    % action
a.nDfRwd = a.cCurRwd + nExpRwd * p.gamma;    % number output 

%% Update the weights - Back Propagation
% compute deltas for action, number and hidden
aDelta = a.aDfRwd - a.aAct(a.actionChoice); 
nDelta = a.nDfRwd - a.nOutAct(a.countChoice); 
hDelta = (a.wts_HA(a.actionChoice,:)' * aDelta + ...
    a.wts_HN(a.countChoice,:)' * nDelta) .* (a.hAct .* (1-a.hAct));

% compute the changes for the weights
wtsHA_change = aDelta * a.hAct';
wtsHN_change = nDelta * a.hAct';
wtsVH_change = hDelta * w.vS.oldInput;
wtsNH_change = hDelta * a.nPrevAct';

% update the weights
a.wts_HA(a.actionChoice,:) = a.wts_HA(a.actionChoice,:) + p.lrate * wtsHA_change;
a.wts_HN(a.countChoice,:)  = a.wts_HN(a.countChoice,:) + p.lrate * wtsHN_change;
a.wts_VH = a.wts_VH + p.lrate * wtsVH_change;
a.wts_NH = a.wts_NH + p.lrate * wtsNH_change;

%% Accumulate activations to the context layer
a.nPrevIn = p.memory * a.nPrevAct + a.nOutAct;
a.nPrevAct = a.nPrevIn;     % no transfer function

%% start over if an incorrect action was made
if p.teachingModeOn && ~w.actionCorrect
    w.tryAgain = true;
end

end
