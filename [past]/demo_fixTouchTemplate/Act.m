% written by professor Jay McClelland
function [ ] = Act( )
% here we act according to the action selected
% by selectAction
global w p;
%% where are hand and eye in rS
w.rS.handPos = w.rS.handPos + w.out.handStep;
w.rS.eyePos = w.rS.eyePos + w.out.eyeStep;

w.rS.td = 1;    % the time difference
w.rS.time = w.rS.time + w.rS.td;    % update the time
end

% % execte the action for either eye or hand
% if w.out.chooseHand == 1
%     w.rS.handPos = w.rS.handPos + w.out.handStep;
%     w.rS.td = p.handTime;
% else
%     w.rS.eyePos = w.rS.eyePos + w.out.eyeStep;
%     w.rS.td = p.eyeTime;
% end
% w.rS.time = w.rS.time + w.rS.td;

