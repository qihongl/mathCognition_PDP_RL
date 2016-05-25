%% plotResolutionBump
clear variables; close all; 
% global p; 
% initParams(0)

x = [-5:.1:5];
norm = normpdf(x,0,1);

h = area(norm);
h.FaceColor = [0.75 0.75 0.75]
xlim([0, 100])
set(gca,'visible','off');