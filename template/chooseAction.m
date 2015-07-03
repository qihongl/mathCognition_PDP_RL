function [w] = chooseAction(w,p,a)

if w.curs == 0
    w.cura = 2; % 0 is the left end point
else
    prob = softmax(a.q(w.curs+1,:), p.qscale);
    w.cura = sample(prob);
end

end

function [c] = sample(pr)
rv = rand(1);
cp = cumsum(pr);
for i = 1:length(pr)
    if rv < cp(i)
        c = i;
        return;
    end
end
end

