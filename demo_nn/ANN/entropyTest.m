clear variables; 
total = 100; 

for freqA = 1 : total-1;    
    x = [freqA, total - freqA];
    pmf = x ./ sum(x);
    ent(freqA) = sum(-pmf .* log(pmf)/log(2));
end

plot(ent)
ylim([0,1])
xlim([0,total])
title('Entropy over balanceness (2 classes)')
xlabel('Frequency of 1 class')
ylabel('Entropy')
