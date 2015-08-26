function initParams()
global p nn w a; 
% initialization 
p.countMax = 10; 
nn.bias = 1; 
w.answer = 0; 
w.goal = 10; 

% init wts 
nn.wts_start = randSmallWeights(p.countMax + 1,1);
end

