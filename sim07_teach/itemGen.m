function targPos = itemGen(nItems)
global p; 

targPos = cumsum(uniform(p.minSpacing,p.maxSpacing, 1,nItems));
targPos = round (targPos - mean(targPos));

%% check if the items are roughly centered
% mean(targPos);
%% check the max spacing of the numbers
% n = 10;
% m = 100;
% counter = 0;
% temp = zeros(m,n);
% for i = 1 : m
%     tmp = round(cumsum(uniform(1,maxSpacing, 1,n)))
%     if any(diff(temp) > 5)
%         disp('!')
%         tmp
%         diff(tmp)
%         counter = counter + 1;
%     end
%     temp (i,:) = tmp;
% end
end