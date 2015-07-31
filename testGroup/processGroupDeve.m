%% this function takes summarized learning data for each group, and save them
function [ deveData ] = processGroupDeve(path)
global p; 

deveData = cell(p.numDir, p.nSubj);

for i = 1 : p.numDir
    % load developmental group data
    fullpath = [path.dataDir{i} '/' path.deveDataName];
    load(fullpath);
    
    for n = 1 : p.nSubj
        deveData{i,n} = pooledScore{n};
    end
    
end




end

