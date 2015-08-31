function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% compute the output activation
% forward propagation
a.hIn = a.wts_VH * w.vS.visInput';
a.hAct = tanh(a.hIn);
a.aIn = a.wts_HA * a.hAct;
a.aAct = a.aIn;     % no transfer function 
% inject bias to action 0 (don't move)
a.aAct(p.mvRad + 1) = a.aAct(p.mvRad + 1) + a.bias;

%% choose among the activation
if w.teacherForcing
    % if it is done unit, don't need to transform to real state
    if w.answer.eye(w.stateNum + 1) == p.mvRange+1
        a.choice = w.answer.eye(w.stateNum + 1);
    else
        a.choice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1;
    end
else
%     a.choice = choose(a.act.^a.smgain);
    a.choice = chooseMax(a.act);
end

%% check if the model is completing the task
if a.choice == length(a.act)
    w.out.targGuess = 0;
    w.out.handStep = 0;
    w.out.eyeStep = 0;
else
    w.out.targGuess = a.choice - p.mvRad - 1; % get vS action
    %% compute the "moving vector" for eye and hand (in vS)
    w.out.handStep = w.out.targGuess - w.vS.handPos;
    w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates
end

end
