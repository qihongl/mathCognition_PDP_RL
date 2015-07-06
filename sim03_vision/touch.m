%% a RL based model for counting
function output = touch(epochs, seed, doPlotting, showSteps, showProgress)
if nargin == 0
    epochs = 100; seed = randi(99);
    doPlotting = true; showSteps = false; showProgress = false;
end
% initialization
rng(seed);

%% modeing parameters
p = setupParameters(epochs);
% preallocate & initilize Q to small values
a.q = .01 + zeros(p.range+1,p.nactions);
h.stepsUsed = zeros(p.trials,1);


%% start training
if showProgress
    textprogressbar('Start training: ');
end
for i = 1:p.trials
    if showProgress
        textprogressbar(i);
    end
    % set up for the current state
    w = initState(p);
    
    % print the targets and spots touched
    if showSteps
        fprintf('\nTargets: %s | spots touched: ', num2str(w.targets));
    end
    while ~w.done
        %% choose action and go to the next state
        w = chooseAction(w,p,a);
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
    
    h.stepsUsed(i) = w.steps;   % save the performance metric
    h.spotsTouched{i} = w.spotsTouched;
    %     qhist(i,:,:) = a.q;
end
if showProgress
    textprogressbar(' Done!');
end

% save the history
output = struct('h',h,'a',a,'p',p);
% plot the performance
if doPlotting
    plotPerformance(output);
end

end


