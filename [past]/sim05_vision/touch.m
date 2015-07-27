%% a RL based model for counting
function output = touch(epochs, seed, ...
    showPlot, showSteps, showProg)
if nargin == 0
    epochs = 100; seed = randi(99); 
    showPlot = 1; showSteps = 0; showProg = 0;
end
rng(seed);

global p

%% initialization
% modeing parameters
setupParameters(epochs);
% preallocate & initilize Q to small values
a.q = .01 + zeros(p.nEyeAct, p.nHandAct);
h.stepsUsed = zeros(p.trials,1);

%% training
if showProg
    textprogressbar('Training: ');
end
for i = 1:p.trials
    if showProg
        textprogressbar(i);
    end
    % set up for the current state
    w = initState();
    
    % print the targets and spots touched
    if showSteps
        fprintf('\n%.4d - Targets: %s | Spots touched: ',...
            i, num2str(w.targets));
    end

    while ~w.done
        %% choose action
        % the model either receive action from the "teacher"...
       
        if w.teach
            w.cura = w.truth(w.steps +1);
        else
            % ... or come up with action by itself
            w.cura = chooseAction(w,a);
        end
        %% go to the next state
        w = nextState(w);
        
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
if showProg
    textprogressbar(' Done!');
end

%% save data
% save the history
output = struct('h',h,'a',a,'p',p);

%% showPlot the performance
if showPlot
    plotPerformance(output);
end

end


