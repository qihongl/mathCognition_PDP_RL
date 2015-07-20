% written by professor Jay McClelland
function [ ] = Act( )
% here we act according to the action selected
% by selectAction
global w;
%% perform the actions 
% update the real locations of hand and eye
if ~w.terminate
    w.rS.handPos = w.rS.handPos + w.out.handStep;
    w.rS.eyePos = w.rS.eyePos + w.out.eyeStep;
else 
    w.rS.handPos = nan;
    w.rS.eyePos = nan;
end

w.rS.td = 1;    % the time difference
w.rS.time = w.rS.time + w.rS.td;    % update the time
end
