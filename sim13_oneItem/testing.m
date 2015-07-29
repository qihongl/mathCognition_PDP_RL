% just testing, a short cut for running the model
function testing(epoch)
if nargin == 0
    epoch = 2000;
end
record = trainAgent(epoch);
save('record','record');

% eval the performance
quiz()
checkLearning()

beep % notice me that the program was ended
end
