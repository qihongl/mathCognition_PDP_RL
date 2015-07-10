% written by professor Jay McClelland
function [] = initParamsEtc( )
%
global p d a

p.wf = .15;
% p.handTime = 5;     % the amount of time needed to move hand 
p.eyeTime = 1;      % the amount of time needed to move eye
p.learner = 1;      % 
p.lrate = .1;      % alpha 
p.runs = 4096;      % epochs
p.gamma = .8;       % discount 
p.smirate = .001;   % ?
% p.eyebias = 2;      %initial bias to prefer eye movement

p.mvRad = 10;
p.mvRange = p.mvRad * 2 + 1;

d.fh = figure();
d.fh.WindowStyle = 'docked';
%d.rSax = subplot(3,1,1);
d.rax = subplot(3,1,1);
d.hax = subplot(3,1,2);
d.wax = subplot(3,1,3);
d.dtimes = 2.^(0:13);

a.wts = zeros(p.mvRange,101);   % preallocate for weights
a.wts = repmat(normpdf(-50:50,0,50),[p.mvRange,1]);

% a bias unit -> action 0 (don't move)
a.bias = 2;

% initialize weights for eye and hand
% a.wts(1,:) = normpdf(-50:50,0,50);
% a.wts(2,:) = p.eyebias*normpdf(-50:50,0,50);
a.smgain = 1;
end

