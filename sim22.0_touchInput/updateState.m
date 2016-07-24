% written by professor Jay McClelland
function [ ] = updateState()
%this function uses the real state to update the internal state
%after Act is called to execute the hand or eye movement action

global w h p a;

%% compute the relative locations
% the relative locations of eye and hand
w.vS.eyePos = 0;
w.vS.handPos = w.rS.handPos - w.rS.eyePos;
% the next line is the apparent new position of the target
% purturbed by scalar variability based on true targ pos

% w.vS.targPos = round((w.rS.targPos - w.rS.eyePos).*(1+randn(1,length(w.rS.targPos))*p.wf));
w.vS.targPos = w.rS.targPos - w.rS.eyePos;

% the error depends on the distance between target and fixation
w.vS.sd = p.sf*abs(w.rS.targPos - w.rS.eyePos); %using spread factor -- jlm
w.vS.sd(w.vS.sd < p.wf) = p.sf; %using spread factor -- jlm
%w.vS.sd(w.vS.targPos == 0) = 0.01; %should have min spread of p.sf, as on
%prev line -- jlm

%% Gaussian representation of visual input
w.vS.visInput_old = w.vS.visInput_cur;
w.vS.visInput_cur = getVisualInput();

% save the history
w.stateNum = w.stateNum + 1;
h(w.stateNum+1).w = w;
end

