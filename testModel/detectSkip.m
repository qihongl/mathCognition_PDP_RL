function numSkips = detectSkip(seq)
% consecutive difference for a vector
consecDiff = diff([0 seq]);
% count number of non-one element, which indicates skipping 
numSkips = length(consecDiff(consecDiff ~= 1));
end