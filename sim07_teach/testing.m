% just testing
clear global
epoch = 2^12;
% initParamsEtc(epoch)
record = trainAgent(epoch);

save('record','record');