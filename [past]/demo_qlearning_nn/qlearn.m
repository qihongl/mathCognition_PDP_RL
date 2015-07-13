function stat=qlearn(stat)

global NO_REPLICATIONS ITERMAX NA NS SMALL TPM TRM LAMBDA

% Q-Learning

% Finding the Max factor in the current state 

q_next=max(value_finder(stat.current_state,1,stat.vector),value_finder(stat.current_state,2,stat.vector));

stat.iter=stat.iter+1;

%learn_rate=1/(stat.iter);

%learn_rate=log(stat.iter+1)/(stat.iter+1);

learn_rate=0.5*300/(300+stat.iter);

q=value_finder(stat.old_state,stat.old_action,stat.vector);

q=q*(1-learn_rate)+(learn_rate*(stat.rimm+(LAMBDA*q_next)));

stat.vector=update_net(q,stat.old_action,stat.old_state,stat.vector);

stat.Q(stat.old_state,stat.old_action)=q;




