% written by professor Jay McClelland
function [] = selectAction( )
% It computes the output, and choose the action probabilistically. 
global w a p;

%% compute the output activation
a.act = a.wts * w.vS.visInput';
% bias toward action 0 (don't move)
a.act(p.mvRad + 1) = a.act(p.mvRad + 1) + a.bias; 
%% choose action according to the activation values
a.choice = choose(a.act.^a.smgain);
%% the last unit -> terminate the task
if a.choice == p.mvRange + 1 
    w.out.targGuess = nan;
    w.terminate = true; 
else
    %% compute the "moving vector" for eye and hand (in vS)
    w.out.targGuess = a.choice - p.mvRad - 1; % get vS targ position
    w.out.handStep = w.out.targGuess - w.vS.handPos;
    w.out.eyeStep = w.out.targGuess; % already in eye-centered coordinates
end


end
