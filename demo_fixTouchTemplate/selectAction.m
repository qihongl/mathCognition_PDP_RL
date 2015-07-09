% written by professor Jay McClelland
function [] = selectAction( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global w a p;

%% compute the normalized activation
% a.net = a.wts * w.vS.visInput';
% scnet = p.smgain*a.net;
% a.act = exp(scnet)/sum(exp(scnet));
%% compute the output activation
a.act = a.wts * w.vS.visInput';
% choose among the activation
a.choice = choose(a.act.^a.smgain);
a.choice = a.choice - p.mvRad - 1; % get vS action
w.out.targGuess = a.choice;           % get action

%% compute the "moving vector" for eye and hand
w.out.handStep = w.out.targGuess - w.vS.handPos;
w.out.eyeStep = w.out.targGuess; %already in eye-centered coordinates
end

% guess the target position based on the input PMF
% targGuess = choose(w.vS.visInput) - 51;

% if p.learner == 0
%     if abs(targGuess) < 3
%         w.out.chooseHand = 1;
%     else
%         w.out.chooseHand = 0;
%     end
% else
% decide which to move
%      if a.choice == 1
%          w.out.chooseHand = 1;
%      else
%          w.out.chooseHand = 0;
%      end
% end

% make the corresponding movements
% if w.out.chooseHand
%         w.out.eyeStep = 0;
%         w.out.handStep = targGuess - w.vS.handPos;
% else
%         w.out.handStep = 0;
%         w.out.eyeStep = targGuess; %already in eye-centered coordinates

