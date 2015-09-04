function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% compute the output activation
% forward prop. 
a.hIn = a.wts_VH * w.vS.visInput';
a.hAct = tanh(a.hIn);
a.aIn = a.wts_HA * a.hAct;
a.aAct = a.aIn;     % no transfer function 
% inject bias to action 0 (don't move)
a.aAct(p.mvRad + 1) = a.aAct(p.mvRad + 1) + a.bias;

% choose action based on the activation in the action layer
if w.teacherForcing
    a.choice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1; 
else
    a.choice = choose(a.aAct.^a.smgain);
end
% get vS action
w.out.targGuess = a.choice - p.mvRad - 1; 

%% compute the "moving vector" for eye and hand (in vS)
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates

end
