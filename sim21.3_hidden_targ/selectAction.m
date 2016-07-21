function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% compute the output activation
% forward prop
% hact = sigmoid(a.wts_ih * w.vS.visInput');
hact = tanh(a.wts_ih * w.vS.visInput');
a.act = a.wts_ho * hact + a.bias;

%% choose among the activation
if w.teacherForcing
    % if it is done unit, don't need to transform to real state
    if w.answer.eye(w.stateNum + 1) == p.mvRange+1
        a.choice = w.answer.eye(w.stateNum + 1);
    else
        a.choice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1;
    end
else
    if a.smgain <= p.smi_upperLim * 2 %added this if statement to eliminate choice variability during testing -- jlm
        a.choice = choose(a.act.^a.smgain);
    else
        [ ~,a.choice] = max(a.act);
    end
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
