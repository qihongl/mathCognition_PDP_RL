function [ dirList ] = getAllDirNames(directory)
% get the file names for all directories in the input dir 
% in the case of ECOG data, this function return all time points! 
dirList = dir(strcat(directory));
dirList(1:2) = []; % the 1st two dir are ".." and "." 

rmidx = []; 
for i = 1 : length(dirList)
%     fprintf('%s\n', dirList(i).name)
    if (~dirList(i).isdir)
%         warning('Non-directory exists, this code does not work');
        rmidx = vertcat(rmidx,i);
    end
    
end

% remove non-directory things
dirList(rmidx) = []; 

end

