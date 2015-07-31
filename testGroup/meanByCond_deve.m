function [r] = meanByCond_deve( deveData )
%UNTITLED18 Summary of this function goes here
%   Detailed explanation goes here
global p;

for i = 1 : p.numDir
    
    for j = 1: p.nSubj
        stepsUsed(:,i) = deveData{i,j}.stepsUsed;
        completeRate(:,i) = deveData{i,j}.completeRate;
        propItemsTouched(:,i) = deveData{i,j}.propItemsTouched;
        propSkips(:,i) = deveData{i,j}.propSkips;
        
    end
end


r.stepsUsed = stepsUsed;
r.completeRate = completeRate;
r.propItemsTouched = propItemsTouched;
r.propSkips = propSkips;


end

