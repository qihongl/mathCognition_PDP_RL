function [] = computeAnswer()
% get the optimal sequence of action that can finish the task
% used for teacher forcing mode 
% 8/16 - revised to adapt the implementation of the completion unit 
global w p;
% compute the best actions to take
answer.eye = diff([w.rS.eyePos w.rS.targPos]);
answer.eye = [answer.eye p.mvRange+1];
answer.hand = diff([w.rS.handPos w.rS.targPos]);
answer.hand = [answer.hand p.mvRange+1];


answer.count = [1 : w.nItems (p.maxCount + 1)];
% answer.count = [1 : w.nItems w.nItems];

% save the answer
w.answer = answer; 
end