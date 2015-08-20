%% Try the XOR problem
close all; clear all;  

%% initialization
% set up the objective mapping 
x = [0 0 1 1; 0 1 0 1];
target = [0 1 1 0];

p.epochs = 1000;

% get the dimensions
[numInput N] = size(x);
[numOutput N] = size(target);
numHidden = 2;

% initialize the weights
wts1 = randSmallWeights(numHidden,numInput+1);
wts2 = randSmallWeights(numOutput,numHidden+1);

%% start training
for iter = 1 : p.epochs; 
    
    for i = 1:N
        for j = 1:numHidden
            netj(j) = wts1(j,1:end-1)*x(:,i)+wts1(j,end);
            % %outj(j) = 1./(1+exp(-netj(j)));
            
            outj(j) = tansig(netj(j));
        end
        % hidden to output layer
        for k = 1:numOutput
            netk(k) = wts2(k,1:end-1)*outj' + wts2(k,end);
            outk(k) = 1./(1+exp(-netk(k)));
            delk(k) = outk(k)*(1-outk(k))*(target(k,i)-outk(k));
        end
        % back propagation
        for j = 1:numHidden
            s=0;
            for k = 1:numOutput
                s = s + wts2(k,j)*delk(k);
            end
            delj(j) = outj(j)*(1-outj(j))*s;
            % %s=0;
            
        end
        for k = 1:numOutput
            for l = 1:numHidden
                wts2(k,l) = wts2(k,l)+.5*delk(k)*outj(l);
            end
            wts2(k,l+1) = wts2(k,l+1)+1*delk(k)*1;
        end
        for j = 1:numHidden
            for ii = 1:numInput
                wts1(j,ii) = wts1(j,ii)+.5*delj(j)*x(ii,i);
            end
            wts1(j,ii+1) = wts1(j,ii+1)+1*delj(j)*1;
        end
    end
end
h = tansig(wts1*[x;ones(1,N)])

y = logsig(wts2*[h;ones(1,N)])

e = target-round(y)