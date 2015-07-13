function record = loadData(PATH)
    fullpath = getPath(PATH);
    load(fullpath, 'record');
end

function fullpath = getPath(PATH)
    fullpath = [PATH.ROOT PATH.DIR PATH.DATA];
end