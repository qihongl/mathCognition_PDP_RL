function [] = trainGroup(nSubj, epoch)
clear global; 
% Run N models, to establish sample size
dataSaveDirName = 'groupData';
projDir = fullfile(pwd, dataSaveDirName);
simName = 'ep2000_freq2000';
param.saveDir = fullfile(projDir, simName);

%% set the parameter that you want to vary
if nargin == 0
    epoch = 2000;
    nSubj = 20;
end

param.runningCondition = 'NA';
% param.val = [1 2 3 4];
param.val = [5 10 30];
% param.val = 0
for i = 1 : length(param.val)
    
    global p;
    %     p.teachingStyle = param.val(i); % varying parameter
    p.replay_batchSize = param.val(i);
    
    %% create a new directory to save the results
    dirName = createDir(param.saveDir, dataSaveDirName);
    
    %% run the group analysis
    for n = 1:nSubj
        % train a model 
        record = trainAgent(epoch, n);
        % save data 
        recordfilename = sprintf('record%.2d', n);
        save([dirName '/'  recordfilename],'record');
        
        if n == 1
            paramfilename = fullfile(dirName,'paramRecord.txt');
            fileID = fopen(paramfilename,'w');
            writeParam(fileID, p)
            fclose(fileID);
        end
    end
    clear global 
end


% write a parameter file
filename = fullfile(param.saveDir,'paramRecord.txt');
fileID = fopen(filename,'w');
writeParam(fileID, param)
fclose(fileID);

beep
end

