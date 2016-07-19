function [ input, answer ] = genLogicGateAnswer( gateType )
% preset all possible input values 
input = [0 0; 0 1; 1 0; 1 1];

% get output 
if strcmp(gateType,'and')
    answer = [0; 0; 0; 1];
elseif strcmp(gateType,'or')
    answer = [0; 1; 1; 1];
elseif strcmp(gateType,'xor')
    answer = [0; 1; 1; 0];
else
    error('unrecognizable gateType type')
end

end

