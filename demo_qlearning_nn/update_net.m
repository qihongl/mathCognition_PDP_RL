function vector=update_net(q,action,state,vector);

global NET_ITERMAX

target=q;

for iter=1:NET_ITERMAX

output=value_finder(state,action,vector);

mu=log(iter+1)/(iter+1);;

vector(action,1)=vector(action,1)+(mu*(target-output)*1);

vector(action,2)=vector(action,2)+(mu*(target-output)*state);

end

