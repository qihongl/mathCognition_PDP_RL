% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global a w p;

%% compute the reward values
w.actionCorrect = true;
% if the model doesn't move (choose the middle action)
if a.choice == p.mvRad + 1
    Rwd = p.r.smallNeg;
%     % actively terminate the task
%     w.stopCount = w.stopCount - 1;
%     if w.stopCount == 0
%         w.done = true;
%         if all(w.rS.targRemain == false)
%             Rwd = p.r.finish;
%         else 
%             Rwd = p.r.bigNeg;
%         end
%     end
else
    % if the model is touching empty spot
    if ~isTouchingObj
        Rwd = p.r.smallNeg;
    else
        % if the model is touching an untouched object
        if objIsUntouched
            % if the object is the leftmost object
            if isNext
                Rwd = p.r.touch;
                w.rS.targRemain(w.rS.targPos == w.rS.handPos) = false;
                
                % if the object is NOT the leftmost object (skip)
            else
                w.actionCorrect = false;  
                Rwd = p.r.midNeg;
                w.rS.targRemain(w.rS.targPos == w.rS.handPos) = false;
                
            end
            % if the model is touching an touched object
        else
            Rwd = p.r.midNeg;
        end
    end
end

%% terminate the task
% give the final reward if all items were touched
if all(w.rS.targRemain == false)
    Rwd = p.r.finish;
    w.done = true;
end

%% assign the reward values
a.Rwd = Rwd;
a.dfRwd = Rwd*p.gamma^w.rS.td;

%% update the weights
% change in weights equals input times reward prediction error
inc = p.lrate*(a.dfRwd - a.act(a.choice));
a.wts(a.choice,:) = a.wts(a.choice,:) + inc*w.vS.oldInput;

%% start over if incorrect action was made
if p.teachingModeOn
    if ~w.actionCorrect
        w.redo = true;
    end
end


end

%% Here're some helper functions to check some conditions

% check if the model is touching the leftmost untouched item
function isnext = isNext()
global w ;
% if it is the leftmost untouched item
if sum(w.rS.targRemain(1:find(w.rS.targPos == w.rS.handPos))) == 1
    isnext = true;
else
    isnext = false;
end
end

% check if the model is touching an object
function isTouching = isTouchingObj()
global w;
if any(w.rS.handPos == w.rS.targPos)
    isTouching = true;
else
    isTouching = false;
end
end

% check if the model that the model is touching is untouched so far
function isUntouched = objIsUntouched()
global w;
if w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true
    isUntouched = true;
else
    isUntouched = false;
end
end

% find the real-state position of the left most untouched item
function position = nextObjPosition()
global w;
    nextItemIdx = find(w.rS.targRemain, true, 'first');
    position = w.rS.targPos(nextItemIdx);
end