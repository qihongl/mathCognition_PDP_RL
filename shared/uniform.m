function [num] = uniform(a,b, row, col)

num = a + (b-a)* rand(row,col);
end