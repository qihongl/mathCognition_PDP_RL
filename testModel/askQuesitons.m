function score = askQuesitons(numQs, showPlot)
%% Quiz the model for n questions
global p;
% preallocate
score = cell(p.maxItems,numQs);
% ask a matrix of questions: cardinality by numQuestions
fprintf('Start testing: %d * %d  questions\n', p.maxItems, numQs)
for cardinality = 1:p.maxItems
    fprintf('%d', cardinality)
    for i = 1: numQs
        % progress bar
        fprintf('.');
        % test the model
        score{cardinality,i} = testModel(showPlot, cardinality);
    end
    fprintf('\n');
end
fprintf('\n')

end
