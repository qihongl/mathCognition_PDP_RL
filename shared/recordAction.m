function index = recordAction()
%% It record the model's action in the form of time series 
% it outputs the index of the object the model is touching right now, 
% it will be zero if the model is not touching anything 
global w h a p;
% get the previous targetRemain situation
prevState = h(size(h,2)).w.rS.targRemain;

% index is 0 by default
index = 0; 
% if current target remain is different from the previous state
if any(w.rS.targRemain ~= prevState)
    % keep track of the changed location 
    % assume that only one item can be differ  
    index = find(prevState ~= w.rS.targRemain);
% if the model choose the stop, asssign a number to it
elseif a.act == p.mvRange +1 
    index = p.maxItems +1;     
end

end