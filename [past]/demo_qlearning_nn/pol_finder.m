function policy=pol_finder(stat)

global NO_REPLICATIONS ITERMAX NA NS SMALL TPM TRM

for state=1:NS
    
    for action=1:NA
        
        Q(state,action)=value_finder(state,action,stat.vector)
        
    end
    
end

for state=1:NS
    
    [maxQfactor,index]=max(Q(state,:));
    
    policy(state)=index;
    
    value_function(state)=maxQfactor;
    
end

policy

value_function

for state=1:NS
    
    for action=1:NA
        state
        action
        Q(state,action)
    end
    
end

stat.vector



