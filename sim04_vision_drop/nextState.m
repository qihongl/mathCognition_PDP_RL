function [ w ] = nextState(w,p)
%NEXTSTATE the trainsition function
% This is a function maps action to the next state

% transit to the target state with probability 1
w.rS.s_handNext = w.rS.s_eyeCur + w.rS.a_handCur;
w.vS.handNext = w.vS.eye + w.rS.a_handCur;

% give the reward for the next state
if w.vS.targetsRemain(w.vS.handNext + p.visualRadius + 1)
    w.vS.targetsRemain(w.vS.handNext + p.visualRadius + 1) = false;
    w.R = p.subR;
    
    % give bonus reward if ALL items were touched
    if all(w.rS.targetsRemain == false)
        w.R = w.R + p.finalR;
        w.done = true;
    end
    
else
    w.R = p.punish;
end

end

