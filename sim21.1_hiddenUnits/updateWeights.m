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
    % save the current transition to the buffer
    updateBuffer();
    % start replay when the buffer is filled
    if a.bufferUsage > a.usage_startReplay
        % take a batch of experience from the buffer 
        for i = 1 : p.replay_batchSize
            % sample from the memory buffer, uniformly w/ replacement
            memoryIdx = sampleFromBuffer();
            %% back propagation 
            % compute the expected rewrad (forward prop)
            [dfRwd, hact] = computeExpectedReward(buffer(memoryIdx).s_next, ...
                buffer(memoryIdx).r_cur, buffer(memoryIdx).taskDone);
            
            % compute delta 
            TD_Err = buffer(memoryIdx).a_act(buffer(memoryIdx).a_cur) - dfRwd;
            delta_ho = TD_Err;
            delta_ih = delta_ho .* a.wts_ho(buffer(memoryIdx).a_cur,:)' .* (1-(hact.^2));

            % adjust the weights 
            a.wts_ho(buffer(memoryIdx).a_cur,:) = a.wts_ho(buffer(memoryIdx).a_cur,:) - p.lrate * delta_ho;
            a.wts_ih = a.wts_ih - p.lrate * delta_ih * buffer(memoryIdx).s_cur; 
                        
            
        end
    end
else
    %% experience replay OFF - update wts w/ current info
    % compute the expected rewrad
    [a.dfRwd, hact] = computeExpectedReward(w.vS.visInput, a.curRwd, w.done);
        
    % compute delta
    TD_Err = a.act(a.choice) - a.dfRwd;
    delta_ho = TD_Err;
    delta_ih = delta_ho .* a.wts_ho(a.choice,:)' .* (1-(hact.^2));
        
    % adjust the weights 
    a.wts_ho(a.choice,:) = a.wts_ho(a.choice,:) - p.lrate * delta_ho;
    a.wts_ih = a.wts_ih - p.lrate * delta_ih * w.vS.oldInput;     
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