function Rwd = computeRwd()
%% this function controls the reward policy
global w a p;
% a
% w.rS
w.actionCorrect = true;
% if there is target remain
% if any(w.rS.targRemain == true)
% if the model doesn't move
if a.choice == p.mvRad + 1
    Rwd = p.r.smallNeg;
    w.stopCounter = w.stopCounter -1;
    if w.stopCounter == 0
        w.done = true; 
        if all(w.rS.targRemain == false)
            Rwd = p.r.bigPos;
        else
            Rwd = p.r.midNeg;
        end
    end
else
    % if the model is touching an empty spot
    if ~isTouchingObj
        Rwd = p.r.smallNeg;
    else
        % if the model is touching an touched object
        if ~objIsUntouched
            Rwd = p.r.midNeg;
            w.actionCorrect = false;
            % if the model is touching an untouched object
        else
            % if the object is the leftmost object
            if isNext
                Rwd = p.r.midPos;
                % if the object is NOT the leftmost object (skip)
            else
                Rwd = p.r.midNeg;
                w.actionCorrect = false;
            end
            w.rS.targRemain(w.rS.targPos == w.rS.handPos) = false;
        end
    end
end
% else
%     %
%     if a.choice == p.mvRad + 1
%         w.done = true;
%         Rwd = p.r.bigPos;
%     else
%         Rwd = p.r.midNeg;
%     end
% end

end % end of the function


%% Here're some helper functions to check some conditions

% check if the model is touching the leftmost untouched item
function isnext = isNext()
global w;
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