function [] = updateInput()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global w
w.input_old = horzcat(w.vS.visInput_old, w.rS.touchLocs_old);
w.input_cur = horzcat(w.vS.visInput_cur, w.rS.touchLocs_cur);
end

