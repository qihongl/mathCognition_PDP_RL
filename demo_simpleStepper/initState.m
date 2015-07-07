% written by Professor Jay McClelland
function [w] = initState( )
% preallocation 
w.nexts = 0;    % next state
w.curs = 0;     % current state
w.cura = 0;     % current action 
w.nexta = 0;    % next action 
w.R = 0;        % reward
w.steps = 0;    % steps used
end

