% written by professor Jay McClelland
function [ ] = updateState()
%this function uses the real state to update the internal state
%after Act is called to execute the hand or eye movement action

global w a d h p;

% the relative locations of eye and hand
w.vS.eyePos = 0;
w.vS.handPos = w.rS.handPos - w.rS.eyePos;
% the next line is the apparent new position of the target
% purturbed by scalar variability based on true targ pos
w.vS.targPos = round((w.rS.targPos - w.rS.eyePos)*(1 + randn*p.wf));

% the error depends on the distance between target and fixation
sd = p.wf*abs(w.rS.targPos - w.rS.eyePos);
sd(sd < p.wf) = p.wf;

% represent the visual input by Gaussian bumps
w.vS.oldInput = w.vS.visInput;
w.vS.visInput = sumMultiItem( w.vS.targPos,sd);

w.rS.aptargPos = w.vS.targPos + w.rS.eyePos;
w.rS.visInput = sumMultiItem(w.rS.aptargPos,sd);

% save the history
w.stateNum = w.stateNum + 1;
h(w.stateNum+1).w = w;
end

