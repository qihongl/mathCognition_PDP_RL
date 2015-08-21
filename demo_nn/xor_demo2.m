clear all; 
%user specified values
p.numHidden = 3;
p.epochs = 10000;
p.lrate = 0.01;
% XOR data
x = [1 1; 1 0; 0 1; 0 0];
y = [1; 0; 0; 1];

%read how many p.numPatterns
p.numPatterns = size(x,1);

%add a bias as an input
bias = ones(p.numPatterns,1);
x = [x bias];

%read how many inputs
p.numInputs = size(x,2);

%set initial random weights
wts1 = randSmallWeights(p.numInputs,p.numHidden);
wts2 = randSmallWeights(1,p.numHidden);

%do a number of p.epochs
for iter = 1:p.epochs
    %loop through all patterns randomly
    for j = 1:p.numPatterns
        %select a random pattern
        patnum = randi(p.numPatterns);
        this_pat = x(patnum,:);
        target = y(patnum,1);
        
        %forward propagation 
        hiddenAct = (tanh(this_pat*wts1))';
%         hiddenAct = (sigmoid(this_pat*wts1))';
        pred = hiddenAct'*wts2';
        
        % back propagation 
        delta3 = pred - target;
        delta2 = delta3.*wts2'.*(1-(hiddenAct.^2));
%         delta2 = delta3.*wts2'.*(hiddenAct.*(1 - hiddenAct));
        % compute the weight changes
        wts2_change = p.lrate * delta3.* hiddenAct;
        wts1_change= p.lrate * delta2 * this_pat;
        % weight update
        wts2 = wts2 - wts2_change';
        wts1 = wts1 - wts1_change';
    end
    
    %plot overall network error at end of each epoch
    pred = wts2*tanh(x*wts1)';
%     pred = wts2*sigmoid(x*wts1)';
    delta3 = pred' - y;
    err(iter) = (sum(delta3.^2))^0.5;
    
    figure(1);
    plot(err)
    ylim([0 max(err)])

    %stop if error is small
    if err(iter) < 0.01
        fprintf('converged at epoch: %d\n',iter);
        break
    end
    
end

%-----FINISHED---------
%display actual,predicted & error
% fprintf('state after %d p.epochs\n',iter);
% a = (y* sigma_out(:,1)) + mu_out(:,1);
% b = (pred'* sigma_out(:,1)) + mu_out(:,1);
% act_pred_err = [a b b-a]


