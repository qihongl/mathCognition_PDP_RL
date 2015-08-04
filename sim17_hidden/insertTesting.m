function [ testScore ] = insertTesting()
%INSERTTESTING During the training, we might want to insert some test
%question, in order to evaluate the model's learning. 
global p;
fprintf('testing...\n');
testScore = cell(p.maxItems, p.testBatchSize);
for nItem = 1 : p.maxItems
    for qNum = 1:p.testBatchSize
        testScore {nItem, qNum} = testModel(false, qNum);
    end
end

end

