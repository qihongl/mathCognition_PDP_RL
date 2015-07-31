function [] = plot_meanByCond_deve( result )

global p; 

subplot(2,2,1)
plotOneMeasure(result.stepsUsed, 'Steps used')
subplot(2,2,2)
plotOneMeasure(result.completeRate, 'Complete rate')
subplot(2,2,3)
plotOneMeasure(result.propSkips, 'Proprtion skips')
subplot(2,2,4)
plotOneMeasure(result.propItemsTouched, 'Proprtion items touched')


end

function plotOneMeasure(mat, tt)
global p; 
FONTSIZE = 14; 
hold on;
for i = 1 : p.numDir
    plot(mat(:,i))
end
title(tt, 'fontsize', FONTSIZE)
xlabel('Time', 'fontsize', FONTSIZE)
legend({'noTeaching', 'tryAgain', 'forcing'}, 'fontsize', FONTSIZE)
hold off;
end