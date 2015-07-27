function plotPerformance( out )
%% plotting 
NUM_TRIALS = size(out.h.stepsUsed,1);

% plot the performance against time + redundent steps
hold on
plot(out.h.stepsUsed)
% plot(getRedunSteps(out.h.spotsTouched))
plot(ones(NUM_TRIALS,1) * out.p.range)

hold off
FONTSIZE = 14;
title('performance against time', 'fontsize', FONTSIZE)
xlabel('epochs', 'fontsize', FONTSIZE);
mylegend = legend('number of steps used',...
    'number of items');
set(mylegend,'FontSize',FONTSIZE);




end

