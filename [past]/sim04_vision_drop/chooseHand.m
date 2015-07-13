function [action] = chooseHand(w,p,a)

% obtain the probability distribution for actions
qval = a.q(w.vS.eye + p.visualRadius + 1,:);
prob = softmax(qval, p.qscale);
% choose action based 
action = sample(prob) - p.visualRadius - 1;

end

function [prob] = softmax(x, scale)
% transform when there is negative values
if any(x < 0)       % TODO: this transformation is not perfect
    x = x - min(x) - 0.0001;
end
% softmax transformation
prob = (x.^scale) / sum(x.^scale);
end

function [ choice ] = sample(strengths)
%choose one of n alternatives according to it's strength
rv = rand;
nstr = strengths/sum(strengths); %normalize strengths
cstr = cumsum(nstr);        %get top edges of bins
choice = find(cstr>rv,1);   %returns the bin v falls in
end



