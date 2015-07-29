% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global a w p;
%% compute the reward values according to the reward policy
Rwd = computeRwd();

%% assign the reward values
a.Rwd = Rwd;
a.dfRwd = Rwd * p.gamma^w.rS.td;

%% update the weights
% change in weights equals input times reward prediction error
inc = p.lrate*(a.dfRwd - a.act(a.choice));          % TODO consider the update rule
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;

%% start over if an incorrect action was made
if p.teachingModeOn && ~w.actionCorrect
    w.redo = true;
end

end