% written by professor Jay McClelland
function [ choice ] = choose(strengths)
%choose one of n alternatives according to it's strength
v = rand; % a number between 0 and 1
nstr = strengths/sum(strengths); %normalize strengths
cstr = cumsum(nstr); %get top edges of bins
choice = find(cstr>v,1); %returns the bin v falls in
end

