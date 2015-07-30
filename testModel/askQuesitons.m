function score = askQuesitons(numQs, showPlot)
%% Quiz the model for n questions
% preallocate
score = cell(1,numQs);
fprintf('Start testing: %d questions\n', numQs)
for i = 1: numQs
    % progress bar
    fprintf('%d\n', i)
    % test the model
    score{i} = testModel(showPlot);
end
fprintf('\n')

end
