function [answer] = computeAnswer()
global w;
% compute the best actions to take
answer.eye = diff([w.rS.eyePos w.rS.targPos]);
answer.eye = [answer.eye 0];
answer.hand = diff([w.rS.handPos w.rS.targPos]);
answer.hand = [answer.hand 0];
end