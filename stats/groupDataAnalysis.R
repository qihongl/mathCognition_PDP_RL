# go to the right directory 
rm(list = ls())
library(gplots)
ROOT = '/Users/Qihong/Dropbox/github/mathCognition'
# construct path
mainDir = 'sim15_forcing+'
subDirName = 'groupData'
name = 'groupData.csv'
numSubDir = 3; 


for( i in 1 : numSubDir){
    subDir = sprintf('%s%.2d', subDirName, i - 1)
    fullpath = sprintf('%s/%s/%s/%s', ROOT, mainDir, subDir, name)       
    data = read.csv(fullpath ,header = F)
    colnames(data) = c('meanSteps', 'monotRate', 'compRate', 'skipRate')
    # assign each data set of a different data frame
    varName = subDir
    assign(varName, data)
}

par(mfrow = c(2,2))

barplot2(c(mean(groupData00$meanSteps),mean(groupData01$meanSteps), mean(groupData02$meanSteps)), 
        xlab="noTeaching, tryAgain, forcing")
title('Mean steps used')

barplot2(c(mean(groupData00$monotRate),mean(groupData01$monotRate), mean(groupData02$monotRate)), 
         xlab="noTeaching, tryAgain, forcing")
title('Monotonic rate')

barplot2(c(mean(groupData00$compRate),mean(groupData01$compRate), mean(groupData02$compRate)), 
         xlab="noTeaching, tryAgain, forcing")
title('Completion rate')

barplot2(c(mean(groupData00$skipRate),mean(groupData01$skipRate), mean(groupData02$skipRate)), 
         xlab="noTeaching, tryAgain, forcing")
title('Skip rate')