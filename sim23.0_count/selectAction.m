function [] = selectAction()
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% compute the output activation
% testInput(w.vS.visInput_cur, w.input_cur(1:p.eyeRange));
a.actVal = a.wts_m_targ * w.input_cur' + a.bias_m;
a.countVal = a.wts_c_targ * w.input_cur' + a.bias_c;

%% choose among the activation
if w.teacherForcing
    % if it is done unit, don't need to transform to real state
    if w.answer.eye(w.stateNum + 1) == p.mvRange+1
        a.action = w.answer.eye(w.stateNum + 1);
    else
        a.action = w.answer.eye(w.stateNum + 1) + p.mvRad + 1;
    end
    % no need to transform count 
    a.count = w.answer.count(w.stateNum + 1);
else
    
    % training phase
    if a.smgain < p.smi_upperLim * 2
        % e-greedy policy 
        if rand > a.epsilon 
            [~, a.action] = max(a.actVal);
            [~, a.count] = max(a.countVal);
        else
            a.action = randsample(length(a.actVal),1);
            a.count = randsample(length(a.countVal),1);
        end
    else
        % testing phase
        [~, a.action] = max(a.actVal);
        [~, a.count] = max(a.countVal);
    end
    
    
end

%% check if the model is completing the task
if a.action == length(a.actVal)
    w.out.targGuess = 0;
    w.out.handStep = 0;
    w.out.eyeStep = 0;
else
    w.out.targGuess = a.action - p.mvRad - 1; % get vS action
    %% compute the "moving vector" for eye and hand (in vS)
    w.out.handStep = w.out.targGuess - w.vS.handPos;
    w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates
end

end
