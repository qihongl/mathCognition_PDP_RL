function targPos = itemGen(nItems)
%% Generate items on the middle of the world, with similar spacing
global p; 

% generate the position vector for the targets
targPos = cumsum(uniform(p.minSpacing,p.maxSpacing, 1,nItems));
% center them
targPos = round (targPos - mean(targPos));
end