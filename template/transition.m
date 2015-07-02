function [ w ] = transition( w, p )
%TRANSITION Summary of this function goes here
%   Detailed explanation goes here
if w.cura == 1
    w.nexts = w.curs - 1;
else
    w.nexts = w.curs +1;
end

if w.nexts == p.range + 1
    w.R = 2;
else
    w.R = 0;
end

end

