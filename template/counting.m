%% a RL based model for counting
function rundata = counting()
% initialization
% clear; clc; rng(0);

%% modeing parameters
p.range = 5;        %
p.gamma = .5;       % discount factor
p.alpha = 0.1;      % learning rate
p.nactions = 2;     % number of possible actions
p.trials = 100;    % training epochs

% preallocate and initilize Q to small values
a.q = .01 + zeros(2*p.range+1,p.nactions);
h.stepsToReward = zeros(p.trials,1);


%% start training
for i = 1:p.trials
    % set up for the current state 
    w.nexts = 0;    % next state
    w.curs = 0;     % current state
    w.cura = 0;     % current action
    w.nexta = 0;    % next action
    w.R = 0;        % reward
    w.steps = 0;    % steps used
    p.qscale = 3;       % softmax scale factor
    
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
        %% updateQandS
        a.q(w.curs+p.range+1,w.cura) = (1-p.alpha)*a.q(w.curs+p.range+1,w.cura)...
            + p.alpha * (w.R + p.gamma * max(a.q(w.nexts+p.range+1,:)));
        
        w.curs = w.nexts;
        w.cura = 0;
        
        w.steps = w.steps+1;
    end
    h.stepsToReward(i) = w.steps;
    %     qhist(i,:,:) = a.q;
end

rundata = struct('h',h,'a',a,'p',p);

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