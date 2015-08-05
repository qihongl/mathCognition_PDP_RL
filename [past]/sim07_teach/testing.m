% just testing, a short cut for running the model 
clear; clear global; 
epoch = 2^2;

record = trainAgent(epoch);

save('record','record');
checkDevelop()