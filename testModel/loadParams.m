function [ ] = loadParams( record )
%LOADPARAMS Summary of this function goes here
%   Detailed explanation goes here
global p a; 
% get the parameters & weights
p = record.p;
a = record.a;
% change parameters
a.smgain = 10;         
p.teacherForcing = 0;   % stop teaching
p.teachingModeOn = 0;
p.lrate = 0;            % stop learning 

end

