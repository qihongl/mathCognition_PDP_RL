function plotWeights(record, plotRange)
if nargin == 1 
    plotRange = 4;
end

global a p; 
a = record.a;
p = record.p;

% 
wts = a.wts';
midIdx = p.mvRad - plotRange :p.mvRad + plotRange;
% 
wts = wts(:,midIdx);

plot(wts)
%
xlim([0 2*p.eyeRad+1])
title('Weights');
xlabel('visual input layer');
ylabel('weight values');

legend_str = num2str((midIdx - p.mvRad)');
legend(legend_str,'location','NorthEast')


end