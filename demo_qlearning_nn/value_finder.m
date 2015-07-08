function qvalue=value_finder(state,action,vector)

global NO_REPLICATIONS ITERMAX NA NS SMALL TPM TRM LAMBDA

qvalue=vector(action,1)+(vector(action,2)*state);




