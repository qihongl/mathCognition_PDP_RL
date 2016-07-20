%% compute the expected reward with the Q learning rule 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% given:    act_next    predicted Q value 
%           s_cur       current state (input)
%           r_cur       current actual reward
%           taskDone    if the task is terminated 
% return:   dfRwd       discounted future reward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dfRwd = computeExpectedReward(s_cur, r_cur, taskDone)
global a p
if ~ taskDone
    % predict the action value 
%     act_next = a.wts * s_cur' + a.bias; % bias for the "dont move" unit
    %% use Q_Targ to evalute the value!  
    act_next = a.wts_targ * s_cur' + a.bias; % bias for the "dont move" unit

    % combine current reward with the expected reward
    dfRwd = r_cur + p.gamma * max(act_next);
else
    % there is no expected reward for the last step
    dfRwd = r_cur;
end
end