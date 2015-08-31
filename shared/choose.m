% written by professor Jay McClelland
function [ choice ] = choose(strengths)
%choose one of n alternatives according to it's strength

% if any(strengths == Inf)
%     % if the strength for some elements are INF, just randomly pick one
%     choice = find(strengths == Inf);
%     if numel(choice) > 1
%         choice = randsample(choice);
%     end
% else
v = rand; % a number between 0 and 1

nstr = strengths/sum(strengths); %normalize strengths
cstr = cumsum(nstr);        %get top edges of bins
choice = find(cstr>v,1);    %returns the bin v falls in

if isempty(choice)
    choice = randi(length(strengths));
end
% end
end

