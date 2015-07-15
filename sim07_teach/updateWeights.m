% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls: 
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global a w p;

%% Assign the reward values
% if it is leftmost untouched item
if any(w.rS.handPos == w.rS.targPos) && ...
        w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true && ...
        isNext()
    % assign appropriate reward
    actionCorrect = true;
    Rwd = 2;
    w.rS.targRemain(w.rS.targPos == w.rS.handPos) = false;
    
    % the reward for touching all items
    if all(w.rS.targRemain == false)
        Rwd = 5;
        w.done = true;
    end
else
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

%% start over if incorrect action was made
if p.teach
    if ~actionCorrect
        w.redo = true;
    end
end

end

function isnext = isNext()
%% check if the model is touching the leftmost untouched item
global w ;
% if it is the leftmost untouched item
if sum(w.rS.targRemain(1:find(w.rS.targPos == w.rS.handPos))) == 1
    isnext = true;
else
    isnext = false;
end
end
