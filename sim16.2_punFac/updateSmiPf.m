function [] = updateSmiPf()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

global a p ;

if a.smgain < p.smi_upperLim
    a.smgain = a.smgain + p.smirate;
end

if a.punishFactor > p.PF_lowerLim
    a.punishFactor = a.punishFactor - p.PFd;
end

end

