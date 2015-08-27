% written by professor Jay McClelland
function [ ] = updateState()
%this function uses the real state to update the internal state
%after Act is called to execute the hand or eye movement action

global w h p a;

%% compute the relative locations
% the relative locations of eye and hand
w.vS.eyePos = 0;
w.vS.handPos = w.rS.handPos - w.rS.eyePos;

%% adding noise to the locations of the obejcts
% 1. iid noise for all objects 
% w.vS.targPos = round((w.rS.targPos - w.rS.eyePos).*(1+randn(1,length(w.rS.targPos))*p.wf));
% 2. same noise for all objects
w.vS.targPos = round((w.rS.targPos - w.rS.eyePos)*(1 + randn*p.wf));
% 3. no noise
% w.vS.targPos = w.rS.targPos - w.rS.eyePos;

%% the error depends on the distance between target and fixation
w.vS.sd = p.wf*abs(w.rS.targPos - w.rS.eyePos);
w.vS.sd(w.vS.sd < p.wf) = p.wf;
w.vS.sd(w.vS.targPos == 0) = 0.01;

%% Gaussian representation of visual input
w.vS.oldInput = w.vS.visInput;
w.vS.visInput = getVisualInput();

% save the history
w.stateNum = w.stateNum + 1;
h(w.stateNum+1).w = w;
end

