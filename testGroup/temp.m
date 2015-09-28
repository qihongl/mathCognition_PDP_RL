numSubj = size(groupDeveScores,1);
numWts = size(groupDeveScores,2);


deveCCR = nan(numWts,1);
deveSR = nan(numWts,1);
deveSER = nan(numWts,1);
deveDTR = nan(numWts,1);
for i = 1 : numWts
    
    sumCCR = 0;
    sumSR = 0;
    sumSER = 0; 
    sumDTR = 0; 
    for j = 1 : numSubj
        sumCCR = sumCCR + groupDeveScores{j,i}.overall.correctCompRate;
        sumSR = sumSR + groupDeveScores{j,i}.overall.meanNumSkips;
        sumSER = sumSR + groupDeveScores{j,i}.overall.stopEarlyRate;
%         sumDTR = sumDTR + groupDeveScores{j,i}.overall.meanNumDoubleTouch;
    end
    deveCCR(i) = sumCCR / numSubj;
    deveSR(i) = sumSR  / numSubj;
    deveSER(i) = sumSER  / numSubj;
%     deveDTR(i) = sumDTR / numSubj;
end

hold on 
plot(deveCCR);
plot(deveSR);
plot(deveSER);
% plot(deveDTR);
hold off

legend({'CCR', 'SR', 'SER'})
xlabel('Epochs * 10')

