% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w;
%% compute the reward values according to the reward policy
curRwd = computeRwd();
expRwd = max(a.act);

if ~w.done
    % if not done, reward = "current + expected"
    a.dfRwd = curRwd + expRwd * p.gamma;
else
    % there is no expected reward for the last step 
    a.dfRwd = curRwd; 
end

%% update the weights
% change in weights equals input times reward prediction error
change = p.lrate*(a.dfRwd - a.act(a.choice)); 
a.wts(a.choice,:) = a.wts(a.choice,:) + change * w.vS.oldInput;

end