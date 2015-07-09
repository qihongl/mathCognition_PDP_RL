%% a RL based model for counting
function rundata = counting(seed, doPlotting)
if nargin == 0
    seed = 0; doPlotting = true;
end
% initialization
rng(seed);

%% modeing parameters
p = setupParameters();
% preallocate and initilize Q to small values
a.q = .01 + zeros(p.range+1,p.nactions);
h.stepsToReward = zeros(p.trials,1);


%% start training
textprogressbar('Start training: ');
for i = 1:p.trials
    textprogressbar(i);
    % set up for the current state
    w = initState();
    
    while abs(w.curs) < p.range
        %% choose action
        w = chooseAction(w,p,a);
        %% go to the next state
        w = nextState(w, p);
%         fprintf('current: (%d,%d) ---> ', w.curs, w.cura)
%         fprintf('next: (%d,%d)\n', w.nexts, w.R)
        
        %% updateQandS
        % update the Q value for current state given current action
        a.q(w.curs+1,w.cura) = (1-p.alpha)*a.q(w.curs+1,w.cura)...
            + p.alpha * (w.R + p.gamma * max(a.q(w.nexts+1,:)));
        
        % update state, action, and steps used
        w.curs = w.nexts;
        w.cura = 0;
        w.steps = w.steps+1;
end
%     fprintf('Iteration %d completed in %d steps!\n\n', i, w.steps)
    h.stepsToReward(i) = w.steps;
    %     qhist(i,:,:) = a.q;
end
textprogressbar(' Done!');

% save the history
rundata = struct('h',h,'a',a,'p',p);
% plot the performance
if doPlotting
    plot(rundata.h.stepsToReward)
end

end


