%% update the memory buffer using the current experience
function [ ] = updateBuffer()
global p a w buffer;

memoryIdx = min(a.bufferUsage+1, p.bufferSize);

if a.bufferUsage+1 <= p.bufferSize
    saveCurrentExperience(memoryIdx)
else
    % delete the 1st experience in the buffer
    buffer(1) = [];
    % preallocate a slot for new experience
    buffer(p.bufferSize) = struct('s_cur', nan, 'a_cur', nan, 'a_act', nan,...
        's_next', nan, 'r_cur', nan, 'taskDone', nan);
    
    saveCurrentExperience(memoryIdx)
end

% keep track of how many slots in the buffer are used
a.bufferUsage = a.bufferUsage + 1;


%% helper function 
% save the current experience to the memory buffer with a specified 
% memory index
    function [] = saveCurrentExperience (memoryIdx)
        % required info 
        buffer(memoryIdx).s_cur = w.vS.oldInput;
        buffer(memoryIdx).a_cur = a.choice;
        buffer(memoryIdx).a_act = a.act;
        buffer(memoryIdx).s_next = w.vS.visInput;
        buffer(memoryIdx).r_cur = a.curRwd;
        
        % other info 
        buffer(memoryIdx).taskDone = w.done;    % if done: no future reward
        
    end

end

