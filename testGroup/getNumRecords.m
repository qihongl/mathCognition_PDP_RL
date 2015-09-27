%% This function counts how many records you have
% It counts number of files that are in the form of "recordXX.mat", where
% XX is the index of the record. Based on this, it will be able to figure
% out the number of subejcts, which is convenient for running analysis. 
function [numSubjects] = getNumRecords(path)

% initialize the counter
numSubjects = 0;

% read all file names
matFiles = dir([path '/*.mat']);
numFiles = length(matFiles);
expression = 'record[0-9][0-9].mat';

% loop over all files
for i = 1 : numFiles
    tempStr = matFiles(i).name;
    % check if the file is in the form of "recordXX.mat"
    temp = regexp(tempStr, expression,'match');
    % increment numSubject if YES
    if(isempty(temp))
%         disp(tempStr);
    else
        numSubjects = numSubjects + 1;
    end
end

fprintf('%s: Got %d subjects\n', path, numSubjects);
end