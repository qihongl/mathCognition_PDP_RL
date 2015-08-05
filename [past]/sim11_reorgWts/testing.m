% just testing, a short cut for running the model
function testing(epoch)
if nargin == 0
    epoch = 5000;
end

record = trainAgent(epoch);
save('record','record');
% checkDevelop()
% quiz(1)
quiz()
end
