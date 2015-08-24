% just testing, a short cut for running the model
function trainOne(epoch, seed)
if nargin == 0
    epoch = 10000;
    seed = randi(99);
end

% run the simulation
record = trainAgent(epoch, seed);

% save the simulation results
saveDirName = getSaveDir();
save([saveDirName '/' 'record'],'record');
save('record','record');

% eval the performance
quiz();
checkLearning();
beep % notice me that the program was ended
end
