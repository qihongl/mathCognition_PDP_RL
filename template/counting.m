%% a RL based model for counting
% initialization
clear; clc; rng(0);

%
p.range = 10;        %
p.gamma = .5;       % discount factor
p.alpha = 0.1;      % learning rate
p.nactions = 2;     % number of possible actions
p.trials = 100;    % training epochs

% preallocate and initilize Q to small values
a.q = .01 + zeros(2*p.range+1,p.nactions);
h.stepsToReward = zeros(p.trials,1);


% start training
for i = 1:p.trials
    w.nexts = 0;    % next state
    w.curs = 0;     % current state
    w.cura = 0;     % current action
    w.nexta = 0;    % next action
    w.R = 0;        % reward
    w.steps = 0;    % steps used
    
    while abs(w.curs) < p.range
        denom = sum(a.q(w.curs+p.range+1,:).^p.qscale);
        prob = (a.q(w.curs+p.range+1,:).^p.qscale)/denom;
        w.cura = sample(prob)
        
        
        getNextState();
        updateQandS();
        w.steps = w.steps+1;
    end
    h.stepsToReward(i) = w.steps;
    %     qhist(i,:,:) = a.q;
end

