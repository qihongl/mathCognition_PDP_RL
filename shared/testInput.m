function [] = testInput()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global w p
if any(w.input_cur(1:p.eyeRange) ~= w.vS.visInput_cur)
    error();
end

end

