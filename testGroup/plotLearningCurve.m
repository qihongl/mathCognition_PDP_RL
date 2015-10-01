%% Plot the learning curve
% This function needs "groupDeveScores"
% Which is computed by testing the wts for all development time points

function plotLearningCurve()
load('groupDeveScores.mat')
%% Get numSubjects and num development time points
numSubj = size(groupDeveScores,1);
numWts = size(groupDeveScores,2);

% preallocation
s.deveCCR = nan(numWts,1);
s.deveSR = nan(numWts,1);
s.deveSER = nan(numWts,1);

% loop over all development time points
for i = 1 : numWts
    % compute average performance acress subjects
    sumCCR = 0;
    sumSR = 0;
    sumSER = 0;
    sumDTR = 0;
    for j = 1 : numSubj
        sumCCR = sumCCR + groupDeveScores{j,i}.overall.correctCompRate;
        sumSR = sumSR + groupDeveScores{j,i}.overall.meanNumSkips;
        sumSER = sumSR + groupDeveScores{j,i}.overall.stopEarlyRate;
    end
    s.deveCCR(i) = sumCCR / numSubj;
    s.deveSR(i) = sumSR  / numSubj;
    s.deveSER(i) = sumSER  / numSubj;
end

visualizeCurve(s, numWts)
end



function visualizeCurve(s, numWts)
FONTSIZE = 14; 
LINEWIDTH = 2; 
% plot it
hold on
plot(s.deveCCR, 'LineWidth', LINEWIDTH);
plot(s.deveSR, 'LineWidth', LINEWIDTH);
plot(s.deveSER, 'LineWidth', LINEWIDTH);
hold off

% add some text 
ylim([0 1])
xlim([0 numWts])
legend({'correcCompRate', 'SkipRate', 'stopEarlyRate'}, 'fontsize', FONTSIZE, 'location', 'northwest')
xlabel('Epochs * 10','fontsize', FONTSIZE)
title('Learning Curve - intermRwd + demon','fontsize', FONTSIZE)
end
