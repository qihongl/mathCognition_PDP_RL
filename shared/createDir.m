function [dirName] = createDir(name)
%% create a directory to save results
if nargin == 0 
    name = 'groupResults';
end

index = 0;
dirName = sprintf('%s%.2d',name, index);
% if directory already exists, use a new name 
while exist(dirName, 'dir') == 7
    index = index + 1;
    dirName = sprintf('%s%.2d',name, index);
end
% make the directory 
mkdir(dirName)

%% make a read me file
readmeName = [dirName '/' 'readme.txt'];
readmeFile = fopen(readmeName, 'wt');
fprintf('Simulation notes:\n')

fclose(readmeFile); % close the file 

end