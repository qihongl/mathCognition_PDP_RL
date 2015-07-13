% written by professor Jay McClelland
function [record] = trainAgent( )
showProgress = false;

global p d a;

% initialize
initParamsEtc();
initPlot();

run = struct('results',[]);
di = 1;

if showProgress
    textprogressbar('Training: ');
end
% train the model for n trials
for i = 1:p.runs
    if showProgress
        textprogressbar(i);
    end
    % run the model 
    run.results = runAgent();
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
if showProgress
    textprogressbar(' Done.');
end

% save the results
record.r = run;
record.p = p;
end