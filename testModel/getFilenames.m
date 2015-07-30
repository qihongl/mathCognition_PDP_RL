%% get file names for all file, so that I can target them
function filenames = getFilenames(filename, nSubj)

% specify the format of the file 
format = '.mat';
% create all file name 
filenames = cell(nSubj,1);
% create all the file name
for n = 1 : nSubj
    filenames{n} = sprintf(['%s%.2d' format], filename, n);
end

end