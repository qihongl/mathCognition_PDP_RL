% just testing, a short cut for running the model
function testing(epoch)
if nargin == 0
    epoch = 10;
end
record = trainAgent(epoch);
save('record','record');
% checkDevelop()
quiz()
end
