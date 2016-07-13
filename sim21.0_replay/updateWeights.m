% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w buffer;
%% compute the reward values according to the reward policy
% compute the true reward at this time step
a.curRwd = computeRwd();

%% experience replay ON - update wts w/ a random sample from the buffer
if p.experienceReply
    
    updateBuffer();

    for i = 1 : p.replay_batchSize
        % sample from the memory buffer
        memoryIdx = randsample(min(p.bufferSize,a.bufferUsage), 1);
        % replay the experience 
        if ~buffer(memoryIdx).taskDone
            % compute the expected reward
            nextAct = a.wts * buffer(memoryIdx).s_next';
            nextAct(p.mvRad + 1) = nextAct(p.mvRad + 1) + a.bias;
            % combine current reward with the expected reward
            dfRwd = buffer(memoryIdx).r_cur + p.gamma * max(nextAct);
        else
            dfRwd = buffer(memoryIdx).r_cur;
        end
        
        % weight update
        change = p.lrate*(dfRwd - buffer(memoryIdx).a_act(buffer(memoryIdx).a_cur));
        a.wts(buffer(memoryIdx).a_cur,:) = a.wts(buffer(memoryIdx).a_cur,:) ...
            + change * buffer(memoryIdx).s_cur;
    end
    
else
    %% experience replay OFF - update wts w/ current info
    if ~w.done
        % compute the expected reward
        a.act_next = a.wts * w.vS.visInput';
        % bias for the "dont move" unit
        a.act_next(p.mvRad + 1) = a.act_next(p.mvRad + 1) + a.bias;
        
        % combine current reward with the expected reward
        a.dfRwd = a.curRwd + p.gamma * max(a.act_next);
    else
        % there is no expected reward for the last step
        a.dfRwd = a.curRwd;
    end
    
    % change in weights equals input times reward prediction error
    change = p.lrate*(a.dfRwd - a.act(a.choice));
    a.wts(a.choice,:) = a.wts(a.choice,:) + change * w.vS.oldInput;
end

end