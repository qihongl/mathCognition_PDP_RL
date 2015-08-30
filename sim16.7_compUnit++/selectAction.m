function [] = selectAction( )
% It computes the output activation, and choose the action probabilistically.
global w a p;

%% compute the output activation
a.act = a.wts * w.vS.visInput';
% inject bias to action 0 (don't move)
% a.act(p.mvRad + 1) = a.act(p.mvRad + 1) + a.bias;

%% choose action (where to move)
if w.teacherForcing
    % if it is done unit
    if w.answer.eye(w.stateNum + 1) == p.mvRange+1
        a.choice = w.answer.eye(w.stateNum + 1);
    else % if it is moving, transform to real state
        a.choice = w.answer.eye(w.stateNum + 1) + p.mvRad + 1;
    end
else % choice using softmax (self exploration mode)
    a.choice = choose(a.act.^a.smgain);
end

%% update where to move
% check if the model is done
if a.choice == length(a.act)
    w.out.targGuess = 0;
    w.out.handStep = 0;
    w.out.eyeStep = 0;
else    % update the where to move if the model is not done
    w.out.targGuess = a.choice - p.mvRad - 1; % get vS action
    % compute the "moving vector" for eye and hand (in vS)
    w.out.handStep = w.out.targGuess - w.vS.handPos;
    w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates
end

end
