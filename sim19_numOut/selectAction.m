function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% Compute the activations for the Action & Number output layers
% sum hidden activation 
a.hIn = a.wts_VH * w.vS.visInput' + a.wts_NH * a.nPrevAct;
a.hAct = sigmoid(a.hIn);
% action layer activation 
a.aIn = a.wts_HA * a.hAct;
a.aAct = a.aIn;
% inject bias to action 0 (don't move)
a.aAct(p.mvRad + 1) = a.aAct(p.mvRad + 1) + a.bias;

% counting layer activation 
a.nOutIn = a.wts_HN * a.hAct;
a.nOutAct = a.nOutIn;           % TODO consider sigmoid transformation
% inject bias to the last unit (saying nothing)
a.nOutAct(p.nCountUnits) = a.nOutAct(p.nCountUnits) + a.bias;

% send activation to the Jordan context layer
a.nPrevIn = p.memory * a.nPrevIn + a.nOutAct;
a.nPrevAct = a.nPrevIn;


% choose action based on the activation in the action layer
if w.teacherForcing
    a.actionChoice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1; 
else
    a.actionChoice = choose(a.aAct.^a.smgain);
    a.countChoice  = choose(a.nOutAct.^a.smgain);
end

% get the count word that the model produced
if a.countChoice == p.nCountUnits
    w.out.countWord = 0;
else
    w.out.countWord = a.countChoice;
end
% get vS action
w.out.targGuess = a.actionChoice - p.mvRad - 1; 

%% compute the "moving vector" for eye and hand (in vS)
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates

end
