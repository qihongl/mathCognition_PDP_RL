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
initPlot(epoch);

% preallocate
run = struct('results',[]);
di = 1;

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
    if i == d.dtimes(di)
        prstr = sprintf('%d: ',i);
        rstr = input(prstr,'s');
        if rstr == 'b'
            break;
        end
        di = di+1;
    end
end
if showProg
    textprogressbar(' Done.');
end

% save the results
record.r = run;
record.p = p;
end