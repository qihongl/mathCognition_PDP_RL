% just testing
clear global
epoch = 2^11;
% initParamsEtc(epoch)
record = trainAgent(epoch, 0,1);
plotResults(record);
save('record','record');