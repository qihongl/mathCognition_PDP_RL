%% a RL based model for counting
function rundata = touch(seed, doPlotting)
if nargin == 0
    seed = randi(99); doPlotting = true;
end
% initialization
rng(seed);

%% modeing parameters
p = setupParameters();
% preallocate and initilize Q to small values
a.q = .01 + zeros(p.range+1,p.nactions);
h.stepsUsed = zeros(p.trials,1);


%% start training
textprogressbar('Start training: ');
for i = 1:p.trials
    textprogressbar(i);
    % set up for the current state
    w = initState(p);
    
    while ~w.done
        %% choose action and go to the next state
        w = chooseAction(w,p,a);
        w = nextState(w, p);
%         fprintf('%d ', w.nexts)
        
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
%     fprintf('\nFound target %d in %d steps!\n\n', w.targets, w.steps)
    h.stepsUsed(i) = w.steps;   % save the performance metric
    h.spotsTouched{i} = w.spotsTouched;
    %     qhist(i,:,:) = a.q;
end
textprogressbar(' Done!');

% save the history
rundata = struct('h',h,'a',a,'p',p);
% plot the performance
if doPlotting
    plotPerformance(rundata);    
end

end


