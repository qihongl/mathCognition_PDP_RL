%% compute the expected reward with the Q learning rule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% given:    act_next    predicted Q value
%           s_cur       current state (input)
%           r_cur       current actual reward
%           taskDone    if the task is terminated
% return:   dfRwd       discounted future reward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dfRwd, hact] = computeExpectedReward(s_cur, r_cur, taskDone)

global a p
% predict the action value
hact = tanh(a.wts_ih* s_cur');
act_next = hact' * a.wts_ho' + a.bias';

if ~ taskDone
    % combine current reward with the expected reward
    dfRwd = r_cur + p.gamma * max(act_next);
else
    % there is no expected reward for the last step
    dfRwd = r_cur;
end
end