% just testing, a short cut for running the model
function record = trainOne(epoch, seed)
clear global 
if nargin == 0
    epoch = 10000;
    seed = randi(99);
    seed = 66 
end


%% run the simulation
global p
record = trainAgent(epoch, seed);

% save the simulation results
saveDirName = getSaveDir();
save([saveDirName '/' 'record'],'record');
save('record','record');

% eval the performance
quiz();
checkLearning();
print([pwd '/' saveDirName '/' 'learningCurve'],'-dpng')

% write a parameter file
filename = fullfile(saveDirName,'paramRecord.txt');
fileID = fopen(filename,'w');
writeParam(fileID, p)
fclose(fileID);

% make sure the current values do not influence the next simulation
clear gobal; 
beep % notice me that the program was terminated!
end
