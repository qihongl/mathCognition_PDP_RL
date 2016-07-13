function [fullpath] = createDir(location,name)
%% create a directory to save results
global p; 

index = 0;
fullname = sprintf('%s%.2d',name, index);
fullpath = fullfile(location, fullname);
% if directory already exists, use a new name 

while exist(fullpath, 'dir') == 7
    index = index + 1;
    fullname = sprintf('%s%.2d',name, index);
    fullpath = fullfile(location, fullname);
end
% make the directory 
mkdir(location, fullname)

%% make a read me file

% filename = fullfile(fullpath,'paramRecord.txt');
% fileID = fopen(filename,'w');
% writeParam(fileID, p)
% fclose(fileID);

end