function [] = updateTouchLocs()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global w p

w.rS.touchLocs_old = w.rS.touchLocs_cur;
% objects in visual range 
observableTrags = abs(w.vS.targPos) < p.eyeRad;
% objects touched 
w.rS.touchLocs_cur = zeros(1,p.eyeRange);
touchedObj = ~w.rS.targRemain;
% objects touched in visual range 
obs_touched = (observableTrags & touchedObj');
% activate touched objects in visual range 
w.rS.touchLocs_cur(w.vS.targPos(obs_touched) + p.eyeRad + 1) = 1; 


% % update the input 
% w.input_old = horzcat(w.vS.visInput_old, w.rS.touchLocs_old);
% w.input_cur = horzcat(w.vS.visInput_cur, w.rS.touchLocs_cur);

end

