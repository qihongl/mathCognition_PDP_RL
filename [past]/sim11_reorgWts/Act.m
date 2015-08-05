% written by professor Jay McClelland
function [ ] = Act( )
% here we act according to the action selected
% by selectAction
global w p;
%% perform the actions 
% update the real locations of hand and eye
w.rS.handPos = w.rS.handPos + w.out.handStep;
w.rS.eyePos = w.rS.eyePos + w.out.eyeStep;

w.rS.td = 1;    % the time difference
w.rS.time = w.rS.time + w.rS.td;    % update the time
end
