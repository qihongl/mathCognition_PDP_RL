function Rwd = computeRwd4()
%% this function controls the reward policy
global w p h;
w.actionCorrect = true;
% if there is remaining items
if targetRemain()
    if w.out.handStep == 0      % not moving
        Rwd = p.r.smallNeg;
        if w.out.countWord == 0
            Rwd = 0;
        end
    elseif ~isTouchingObj       % touching empty spot
        Rwd = p.r.smallNeg;
        if w.out.countWord == 0
            Rwd = 0;
        end
    elseif objIsTouched         % touching touched object
        Rwd = p.r.midNeg;
        if w.out.countWord == 0
            Rwd = 0;
        end
        w.actionCorrect = false;
    elseif ~isNext  % not touching left most untouched obj
        Rwd = p.r.midNeg;
        w.actionCorrect = false;
        w.rS.targRemain(w.rS.handPos == w.rS.targPos) = false;
        if w.out.countWord == sum(w.rS.targRemain == 0)
            Rwd = p.r.midPos;
        end
    else            % CORRECT: touching left most untouched obj
        Rwd = p.r.midPos;
        w.rS.targRemain(w.rS.handPos == w.rS.targPos) = false;
        if w.out.countWord == sum(w.rS.targRemain == 0)
            Rwd = p.r.midPos * 2;
        end
    end
else    % if all targets were touched
    if w.out.countWord == w.nItems
        Rwd = p.r.bigPos;
        w.done = true;
    elseif w.out.countWord == 0
        Rwd = 0;
    else
        Rwd = p.r.smallNeg;
    end
end

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

% check if the model that the model is touching is untouched object
% assuming an object is being touched
function isTouched = objIsTouched()
global w;
if w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true
    isTouched = false;
else
    isTouched = true;
end
end

% check if there exists untouched objects
function exist = targetRemain()
global w;
if any(w.rS.targRemain == true)
    exist = true;
else
    exist = false;
end
end

% find the real-state position of the left most untouched item
function position = nextObjPosition()
global w;
nextItemIdx = find(w.rS.targRemain, true, 'first');
position = w.rS.targPos(nextItemIdx);
end