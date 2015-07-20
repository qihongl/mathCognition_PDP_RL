function plotWeights(record)

a = 0;
wts = record.a.wts';

colIdx = sum(wts) == max(sum(wts));
idx = true(size(wts,2),1);
idx(colIdx) = false;
plot(wts(:,idx))


title('weights (exclude the largest)');
xlabel('visual input layer');
ylabel('weight values');

legend_str = num2str(find(idx==true));
legend(legend_str,'location','NorthEast')

end