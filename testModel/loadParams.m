function [ ] = loadParams( record )
%LOADPARAMS Summary of this function goes here
%   Detailed explanation goes here
global p a; 
% get the parameters & weights
p = record.p;
a = record.a;
% change parameters
a.smgain = 10;         
p.teacherForcingOn = false;   % stop teaching
p.teachingModeOn = false;
p.lrate = 0;            % stop learning 

end

