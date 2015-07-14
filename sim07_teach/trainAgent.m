% written by professor Jay McClelland
function [record] = trainAgent(epoch, showPlot, showProg)
if nargin == 0
    epoch = 1024;
    showPlot = false;
    showProg = false; 
end

% initialize parameters
global p d a;
initParamsEtc(epoch);
initPlot();
% preallocate
run = struct('results',[]);

if showProg
    textprogressbar('Training: ');
end
% train the model for n trials
for i = 1:p.runs
    if showProg
        textprogressbar(i);
    end
    % run the model
    run.results = runAgent(showPlot);
    % ?
    a.smgain = a.smgain + p.smirate;
end
if showProg
    textprogressbar(' Done.');
end

% save the results
record.r = run;
record.p = p;
end