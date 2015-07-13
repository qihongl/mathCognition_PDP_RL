function isnext = isNext()
%% This function decides
% It assumes the handposition conincides with 1 item in the world
global w ;
% isnext is false by default
isnext = false;
% if the target is touched
if w.rS.targRemain(w.rS.handPos == w.rS.targPos) == true
    % if it is the 1st item
    if (find(w.rS.targPos == w.rS.handPos) - 1) == 0
        isnext = true;
        % or if the previous item was touched
    elseif w.rS.targRemain(find(w.rS.targPos == w.rS.handPos) - 1) == 0
        isnext = true;
    end
end
end