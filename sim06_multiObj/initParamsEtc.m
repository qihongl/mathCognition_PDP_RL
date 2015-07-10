% written by professor Jay McClelland
function [] = initParamsEtc( )
global p d a

p.wf = .1;
% p.handTime = 5;     % the amount of time needed to move hand 
% p.eyeTime = 1;      % the amount of time needed to move eye
p.learner = 1;      % 
p.lrate = .1;      % alpha 
p.runs = 4096;      % epochs
p.gamma = .8;       % discount 
p.smirate = .001;   % ?

% the movement range, which defintes the set of actions
p.mvRad = 10;       % the max unit that the model can move
p.mvRange = p.mvRad * 2 + 1;

d.fh = figure();
d.fh.WindowStyle = 'docked';
%d.rSax = subplot(3,1,1);
d.rax = subplot(3,1,1);
d.hax = subplot(3,1,2);
d.wax = subplot(3,1,3);
d.dtimes = 2.^(2:13);

% initialize with small small random values 
a.wts = (1+(-2).*rand(p.mvRange,101))./ 100;

% a bias unit -> action 0 (don't move)
a.bias = 2;

a.smgain = 1;
end

