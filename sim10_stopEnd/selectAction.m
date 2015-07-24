% written by professor Jay McClelland
function [] = selectAction( )
% It computes the output, and choose the action probabilistically. 
global w a p;

%% compute the output activation
a.act = a.wts * w.vS.visInput';
% bias toward action 0 (don't move)
a.act(p.mvRad + 1) = a.act(p.mvRad + 1) + a.bias; 
% choose among the activation
a.choice = choose(a.act.^a.smgain);
w.out.targGuess = a.choice - p.mvRad - 1; % get vS action
%% compute the "moving vector" for eye and hand (in vS)
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates
end
