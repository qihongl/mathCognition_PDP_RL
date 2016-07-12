% just testing, a short cut for running the model
function record = trainOne(epoch, seed)
if nargin == 0
    epoch = 5000;
    seed = randi(99);
%     seed = 66       % works for no replay 
end

%% run the simulation
record = trainAgent(epoch, seed);

%% save the simulation results
saveDirName = getSaveDir();
save([saveDirName '/' 'record'],'record');
save('record','record');

%% eval the performance
quiz();
checkLearning();
print([pwd '/' saveDirName '/' 'learningCurve'],'-dpng')

% end the simulation
clear gobal; % make sure the current values do not influence the next simulation
beep % notice me that the program was terminated!
end
