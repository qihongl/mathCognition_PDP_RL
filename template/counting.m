%% a RL based model for counting
function rundata = counting()
% initialization
% clear; clc; rng(0);

%% modeing parameters
p = setupParameters();
% preallocate and initilize Q to small values
a.q = .02 + zeros(2*p.range+1,p.nactions);
h.stepsToReward = zeros(p.trials,1);


%% start training
for i = 1:p.trials
    % set up for the current state
    w = initState();
    
    while abs(w.curs) < 5
        %% choose action
        denom = sum(a.q(w.curs+p.range+1,:).^p.qscale);
        prob = (a.q(w.curs+p.range+1,:).^p.qscale)/denom;
        w.cura = sample(prob);
        
        %% get next state
        if w.cura == 1
            w.nexts = w.curs - 1;
        else
            w.nexts = w.curs +1;
        end
        if w.nexts == 5
            w.R = 1;
        else
            w.R = 0;
        end
        
        fprintf('current: (%d,%d) ---> ', w.curs, w.cura)
        fprintf('next: (%d,%d)\n', w.nexts, w.R)
        
        
        %% updateQandS
        % update the Q value for current state given current action
        a.q(w.curs+p.range+1,w.cura) = (1-p.alpha)*a.q(w.curs+p.range+1,w.cura)...
            + p.alpha * (w.R + p.gamma * max(a.q(w.nexts+p.range+1,:)));
        
        % update state, action, and steps used
        w.curs = w.nexts;
        w.cura = 0;
        w.steps = w.steps+1;
    end
    fprintf('Iteration %d completed in %d steps!\n\n', i, w.steps)
    h.stepsToReward(i) = w.steps;
    %     qhist(i,:,:) = a.q;
end

% save the history
rundata = struct('h',h,'a',a,'p',p);
% plot the performance
plot(rundata.h.stepsToReward)

end


function [c] = sample(pr)
rv = rand(1);
cp = cumsum(pr);
for i = 1:length(pr)
    if rv < cp(i)
        c = i;
        return;
    end
end
end