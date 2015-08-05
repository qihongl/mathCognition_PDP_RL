function [ saveName ] = getSaveDir(  )
% create a directory to save the simulation data
% the directory will be in the format of 'sim001'

dataName = 'sim';

% create a data dir
dataFolderName = 'data';
if exist(dataFolderName) ~= 7
    mkdir(dataFolderName);
end

% set the default name 
index = 1;
saveName = sprintf('%s/%s%.3d', dataFolderName, dataName, index);
% increment the index until an unused index was found 
while exist(saveName) == 7
    index = index + 1; 
    saveName = sprintf('%s/%s%.3d',dataFolderName , dataName, index);
end

% make the directory
mkdir(saveName)

end
