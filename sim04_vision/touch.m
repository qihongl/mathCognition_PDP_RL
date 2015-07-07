%% a RL based model for counting
function output = touch(epochs, seed, doPlotting, showSteps, showProgress)
if nargin == 0
    epochs = 100; seed = randi(99);
    doPlotting = true; showSteps = false; showProgress = false;
end
rng(seed);

%% initialization
% modeing parameters
p = setupParameters(epochs);
% preallocate & initilize Q values to small quantities
a.q = .01 + zeros(p.range+1,p.nactions);
h.stepsUsed = zeros(p.trials,1);

%% training
if showProgress
    textprogressbar('Training: ');
end
for i = 1:p.trials
    w = initState(p);   % set up for the current state
    
    if showProgress
        textprogressbar(i);
    elseif showSteps
        fprintf('\n%.4d - Targets: %s | Spots touched: ',...
            i, num2str(w.targets));
    end
    while ~w.done
        %% choose action and go to the next state
        w.cura = chooseAction(w,p,a);
        w = nextState(w,p);
        
        % show spots touched
        if showSteps
            fprintf('%d ', w.nexts)
        end
        
        %% update Q values
        % update the Q value for current state given current action
        a.q(w.curs+1,w.cura) = (1-p.alpha)*a.q(w.curs+1,w.cura)...
            + p.alpha * (w.R + p.gamma * max(a.q(w.nexts+1,:)));
        
        %% update state, action, and steps used
        w.curs = w.nexts;
        w.cura = 0;
        w.steps = w.steps+1;
        w.spotsTouched(w.steps) = w.nexts;
        
    end
    % save the performance metric
    h.stepsUsed(i) = w.steps;
    h.spotsTouched{i} = w.spotsTouched;
end
% end of the training
if showProgress
    textprogressbar(' Done!');
end

%% save data
% save the history
output = struct('h',h,'a',a,'p',p);

%% plot the performance
if doPlotting
    plotPerformance(output);
end

end


