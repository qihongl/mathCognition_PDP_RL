% take average of the weights
function averagingWts()
global p;
FONTSIZE = 14;
NSUBJ = 20;
NAME = 'record';

%% get the weights
wts = cell(NSUBJ,1);
for i = 1 : NSUBJ
    filename = sprintf('%s%.2d.mat', NAME, i);
    load(filename);
    wts{i} = record.a.wts;
end
p = record.p;

%% averaging the weights
meanWts = zeros(record.p.mvRange+1, record.p.eyeRange);
for i = 1 : NSUBJ
    meanWts = meanWts + wts{i};
end

%% visualize the weights 
visualizeWeightsMatrix(meanWts / NSUBJ)

% adding some text
title('Connection strength', 'fontsize', FONTSIZE)
xlabel('Visual input layer', 'fontsize', FONTSIZE)
ylabel('Action layer (last unit = "done")', 'fontsize', FONTSIZE)
% save the plot
print([pwd '/' 'meanWts'],'-dpng')

end

function visualizeWeightsMatrix(wts)
global p;
imagesc(-p.eyeRad:p.eyeRad,-p.mvRad:p.mvRad+1, wts)
set(gca,'xtick',-p.eyeRad:1:p.eyeRad);
set(gca,'ytick',-p.mvRad:1:p.mvRad+1);
end