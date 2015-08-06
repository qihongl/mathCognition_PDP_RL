function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% Forward prop. 
%% Send two input layers activations to the hidden layers
% sum hidden activation 
a.hIn = a.wts_VH * w.vS.visInput' + a.wts_NH * a.nPrevAct;
a.hAct = sigmoid(a.hIn);

%% Compute the activations for the Action output layers
a.aIn = a.wts_HA * a.hAct;
a.aAct = a.aIn;             % no transfer function
% inject bias to action 0 (don't move)
a.aAct(p.mvRad + 1) = a.aAct(p.mvRad + 1) + a.bias;

%% Compute the activations for the Counting output layers
a.nOutIn = a.wts_HN * a.hAct;
a.nOutAct = a.nOutIn;       % no transfer function
% inject bias to the last unit (saying nothing)
a.nOutAct(p.nCountUnits) = a.nOutAct(p.nCountUnits) + a.bias * 20;

%% choose move and number actions based on the output activations 
if w.teacherForcing
    a.actionChoice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1; 
else
    a.actionChoice = choose(a.aAct.^a.smgain);
    a.countChoice  = choose(a.nOutAct.^a.smgain);
end

%% get the output action and count word that the model produced
% get vS action
w.out.targGuess = a.actionChoice - p.mvRad - 1; 
% get count word
if a.countChoice == p.nCountUnits
    w.out.countWord = 0;
else
    w.out.countWord = a.countChoice;
end

%% compute the "moving vector" for eye and hand (in vS)
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates

end
