% written by professor Jay McClelland
function [] = initParamsEtc( )
global p d a

%% modeling parameters 
p.wf = .2;
% p.handTime = 5;     % the amount of time needed to move hand 
% p.eyeTime = 1;      % the amount of time needed to move eye
p.learner = 1;      % 
p.lrate = .1;      % alpha 
p.runs = 4096;      % epochs
p.gamma = .8;       % discount 
p.smirate = .001;   % ?

% size of the state space and percetual span
p.spRad = 50;
p.spRange = p.spRad * 2 + 1;
p.mvRad = 10;       % the max unit that the model can move
p.mvRange = p.mvRad * 2 + 1;

p.nItems = 3;
% p.nItems = randi(x);


d.fh = figure();
d.fh.WindowStyle = 'docked';
%d.rSax = subplot(3,1,1);
d.rax = subplot(3,1,1);
d.hax = subplot(3,1,2);
d.wax = subplot(3,1,3);
d.dtimes = 2.^(10:13);

% initialize with small small random values 
a.wts = randsmall(p.mvRange,101);

% a bias unit -> action 0 (don't move)
a.bias = 2;

a.smgain = 1;
end

