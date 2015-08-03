% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
curRwd = computeRwd();
expRwd = max(a.aAct);
%% assign the reward values
a.dfRwd = curRwd;
% a.dfRwd = curRwd + expRwd * p.gamma;

%% update the weights - back prop
% delta for all unit
delta3 = a.dfRwd - a.aAct(a.choice); 
delta2 = a.wts2(a.choice, :)' * delta3 .* (sigmoid(a.hIn) .* (1 - sigmoid(a.hIn)));
% compute the changes for the weights
wts2_change = delta3 * a.hAct';
wts1_change = delta2 * w.vS.visInput;
% update the weights
a.wts2(a.choice,:) = a.wts2(a.choice,:) + p.lrate * wts2_change;
a.wts1 = a.wts1 + p.lrate * wts1_change;

%% start over if an incorrect action was made
if p.teachingModeOn && ~w.actionCorrect
    w.redo = true;
end

end