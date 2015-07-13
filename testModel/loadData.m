function [record] = loadData(PATH)
    fullpath = getPath(PATH);
    load(fullpath, 'record');
    addpath(getPath(PATH));
end

function fullpath = getPath(PATH)
    fullpath = [PATH.ROOT PATH.DIR PATH.DATA];
end

function path = getPath(PATH)
    path = [PATH.ROOT PATH.DIR];
end