function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% compute the output activation
% forward prop. 
a.hAct = tanh(a.wts_VH * w.vS.visInput');
a.aAct = a.wts_HA * a.hAct; 
% inject bias to action 0 (don't move)
a.aAct(p.mvRad +1) = a.aAct(p.mvRad +1) + a.bias;

%% choose among the activation
if w.teacherForcing
    a.choice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1; 
else
    a.choice = choose(a.aAct.^a.smgain);
end
% get vS target guess
w.out.targGuess = a.choice - p.mvRad - 1; 

%% compute the "moving vector" for eye and hand (in vS)
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates

end
