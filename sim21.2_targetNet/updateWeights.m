% written by professor Jay McClelland
function [ ] = updateWeights()
% this function controls:
% 1. the reward policy
% 2. the weight update
% 3. activate the "teaching"
global p a w buffer;
%% compute the reward values according to the reward policy
% compute the true reward at this time step


%% experience replay ON - update wts w/ a random sample from the buffer
if p.experienceReply
    % save the current transition to the buffer
    updateBuffer();
    % start replay when the buffer is filled
    if a.bufferUsage > a.usage_startReplay
        % take a batch of experience from the buffer
        for i = 1 : p.replay_batchSize
            % sample from the memory buffer, uniformly w/ replacement
            memoryIdx = sampleFromBuffer();
            
            % compute the expected rewrad
            dfRwd = computeExpectedReward(buffer(memoryIdx).s_next, ...
                buffer(memoryIdx).r_cur, buffer(memoryIdx).taskDone);
            % weight update
            TD_Err = dfRwd - buffer(memoryIdx).a_act(buffer(memoryIdx).a_cur);
            a.wts(buffer(memoryIdx).a_cur,:) = a.wts(buffer(memoryIdx).a_cur,:) ...
                + p.lrate * TD_Err * buffer(memoryIdx).s_cur;
        end
    end
else
    %% experience replay OFF - update wts w/ current info
    % compute the expected rewrad
    a.dfRwd = computeExpectedReward(w.vS.visInput, a.curRwd, w.done);
    % change in weights equals input times reward prediction error
    TD_Err = a.dfRwd - a.act(a.choice);
    a.wts(a.choice,:) = a.wts(a.choice,:) + p.lrate * TD_Err * w.vS.oldInput;
    if p.curEpoch == 2
        temp = 0;
    end
end

end


%% HELPER FUNCTIONS

% take a transition from the memory buffer
function [memoryIdx] = sampleFromBuffer()
global a p;

if strcmp(p.replaySamplingMode, 'uniform')
    % sample uniformly
    memoryIdx = randsample(min(p.bufferSize,a.bufferUsage), 1);
elseif strcmp(p.replaySamplingMode, 'softmax')
    % sample using softmax distribution, w.r.t the TD error
    memoryIdx = choose(softmaxDistribution_TDErr());
else
    error('ERROR: unrecognizable sampling mode for experience replay!')
end



% compute the softmax distribution of the TD error
    function [distribution_TDErr] = softmaxDistribution_TDErr()
        global buffer
        %% TODO check if the buffer is filled!
        
        TDErrs = nan(p.bufferSize,1);
        for i = 1 : length(buffer)
            TDErrs(i) = buffer(i).TDErr;
        end
        TDErrs = abs(TDErrs);
        distribution_TDErr = exp(TDErrs) / sum(exp(TDErrs));
    end
end