function plotPerformance( rundata )

%% data preprocessing
% numTrials = size(rundata.h.spotsTouched,1);
% redundantSpots = nan(numTrials,1);
% for i = 1 : numTrials
%     allSpots = size(rundata.h.spotsTouched{i},2);
%     uniqueSpots = size(unique(rundata.h.spotsTouched{i}),2);
%     redundantSpots(i) = allSpots - uniqueSpots;
% end


%% plotting 

% plot the performance against time
hold on
plot(rundata.h.stepsUsed)
% plot redundent steps
% plot(redundantSpots)
plot(ones(100,1) * rundata.p.range)

hold off
% FONTSIZE = 14;
% title('performance against time', 'fontsize', FONTSIZE)
% xlabel('epochs', 'fontsize', FONTSIZE);
% mylegend = legend('number of steps used','number of redundant spots visited',...
%     'number of spots in the world');
% set(mylegend,'FontSize',FONTSIZE);

end

