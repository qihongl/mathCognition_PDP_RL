function [] = trainGroup(nSubj, epoch)
clear global; 
% Run N models, to establish sample size
global p;
dataSaveDirName = 'groupData';
projDir = fullfile(pwd, dataSaveDirName);
simName = 'ep20000';
param.saveDir = fullfile(projDir, simName);

%% set the parameter that you want to vary
if nargin == 0
    epoch = 20000;
    nSubj = 20;
end

param.runningCondition = 'fix teaching mode, varying replay buffer parameter';
% param.val = [1 2 3 4];
% param.val = [2 16 32];
param.val = 0
for i = 1 : length(param.val)
    %     p.teachingStyle = param.val(i); % varying parameter
%     p.replay_batchSize = param.val(i);
    
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
        clear global 
    end
    
end


% write a parameter file
filename = fullfile(param.saveDir,'paramRecord.txt');
fileID = fopen(filename,'w');
writeParam(fileID, param)
fclose(fileID);

beep
end

