function targPos = itemGen(nItems)

global p; 

% generate the positions for the targets
targPos = cumsum(uniform(p.minSpacing,p.maxSpacing, 1,nItems));
% center them
targPos = round (targPos - mean(targPos));
end