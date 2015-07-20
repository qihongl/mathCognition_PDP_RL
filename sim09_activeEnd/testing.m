% just testing, a short cut for running the model
function testing()

if nargin == 0
    epoch = 5000;
    
    record = trainAgent(epoch);
    save('record','record');
    checkDevelop()
else
    % run group analysis
end

end
