function [ saveName ] = getSaveDir(  )
% create a directory to save the simulation data
% the directory will be in the format of 'sim001'

% set the default name 
defaultName = 'sim';
index = 1;
saveName = sprintf('%s%.3d', defaultName, index);
% increment the index until an unused index was found 
while exist(saveName) == 7
    index = index + 1; 
    saveName = sprintf('%s%.3d', defaultName, index);
end

% make the directory
mkdir(saveName)

end

