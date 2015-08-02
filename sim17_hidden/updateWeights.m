% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
curRwd = computeRwd();
% expRwd = max(a.wts*w.vS.visInput');
expRwd = max(a.aAct);
%% assign the reward values
% a.Rwd = curRwd;
a.dfRwd = curRwd + expRwd * p.gamma;

%% update the weights
% change in weights equals input times reward prediction error
delta2 = p.lrate*(a.dfRwd - a.aAct(a.choice)); 
a.wts(a.choice,:) = a.wts(a.choice,:) + delta2*w.vS.oldInput;

%% start over if an incorrect action was made
if p.teachingModeOn && ~w.actionCorrect
    w.redo = true;
end

end