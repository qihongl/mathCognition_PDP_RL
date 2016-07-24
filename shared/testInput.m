function [] = testInput(x,y)
if any(x ~= y)
    error('THE TWO INPUTS ARE DIFFERENT.');
end
end

