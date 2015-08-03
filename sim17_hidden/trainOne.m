% just testing, a short cut for running the model
function trainOne(epoch)
if nargin == 0
    epoch = 3000;
end

% run the simulation
record = trainAgent(epoch);

% save simulation data
saveDirName = getSaveDir();
save([saveDirName '/' 'record'],'record');
save('record','record');

% eval the performance
quiz();
checkLearning();
beep % notice me that the program was ended
end
