function plotWeights(record)

% a = 0;
x = 6:10;
wts = record.a.wts';

% 
wts = wts(:,x);

% colIdx = sum(wts) == max(sum(wts));
% idx = true(size(wts,2),1);
% idx(colIdx) = false;
plot(wts)
% 
% idx(idx == 0) = 1;

title('weights (exclude the largest)');
xlabel('visual input layer');
ylabel('weight values');

legend_str = num2str(x');
legend(legend_str,'location','NorthEast')

end