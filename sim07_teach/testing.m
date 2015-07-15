% just testing, a short cut for running the model 
clear; clear global; 
epoch = 2^10;

record = trainAgent(epoch);

save('record','record');