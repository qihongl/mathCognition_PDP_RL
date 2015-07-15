function plotResults(record)
global d;
% initialize the parameters for the plot
d.fh = figure();
d.fh.WindowStyle = 'docked';
d.rax = subplot(3,1,1);
d.hax = subplot(3,1,2);
d.wax = subplot(3,1,3);
% d.dtimes = 2.^(10:10);

% load('record.mat');
for i = 1 : size(record.r{size(record.r,2)}.h,2)
    plotRes(i, record);
end

end

%% plot the behavior of the model, given the saved data
function plotRes(i, record)
global p w a;

% load data
p = record.p;
a = record.r{size(record.r,2)}.a;
w = record.r{size(record.r,2)}.h(i).w;
showState();
end
