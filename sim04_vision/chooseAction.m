function [action] = chooseAction(w,p,a)

% choose to move eye or move hand

% obtain the probability distribution for actions
prob = softmax(a.q(w.curs+1,:), p.qscale);
% choose action based 
action = sample(prob);

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



