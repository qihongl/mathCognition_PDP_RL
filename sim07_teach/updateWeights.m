% written by professor Jay McClelland
function [ ] = updateWeights()
global a w p;

%% Assign the reward values
% if the hand is touching a item, and that item is untouched before
if any(w.rS.handPos == w.rS.targPos) && w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true
    actionCorrect = true;
    Rwd = 0.5;
    if isNext
        Rwd = Rwd + 2;
    end    
    w.rS.targRemain(w.rS.targPos == w.rS.handPos) = false;
    
    % the reward for touching all items
    if all(w.rS.targRemain == false)
        Rwd = 5;
        w.done = true;
    end
else
    % the reward value by default
    actionCorrect = false;
    Rwd = -0.05;
end

% assign the reward values
a.Rwd = Rwd;
a.dfRwd = Rwd*p.gamma^w.rS.td;

%% update the weights
% change in weights equals input times reward prediction error
inc = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;

%% teaching specific
% if ~actionCorrect
    % feedback
    % adjust the weights (how does it differ from correct?)
    % force action (how?)
% end
end
