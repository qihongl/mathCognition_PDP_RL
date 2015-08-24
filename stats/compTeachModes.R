# Compare the performance across different ways of teaching
rm(list = ls())
library(ggplot2); library(plyr); library(tidyr); library(dplyr)
setwd('/Users/Qihong/Dropbox/github/mathCognition/stats')
source('multiplot.R'); source('se.R')
# load data
mydata = read.csv('repli3.csv', header = F)

colnames(mydata) = c('parameter', 'meanSteps', 'monoRate', 'compRate', 'correctCompRate', 'skipRate',
                     'steps1', 'steps2', 'steps3', 'steps4', 'steps5', 'steps6', 'steps7',
                     'CR1','CR2','CR3','CR4','CR5','CR6','CR7',
                     'CCR1','CCR2','CCR3','CCR4','CCR5','CCR6','CCR7')
# IMPORTANT! - set the condition label
mydata$parameter[mydata$parameter == 0] = '1.finalRwdOnly'
mydata$parameter[mydata$parameter == 1] = '2.interm'
mydata$parameter[mydata$parameter == 2] = '3.demon'
mydata$parameter[mydata$parameter == 3] = '4.demon+interm'
# mydata$parameter[mydata$parameter == 4] = '5.interm_s0'
# mydata$parameter[mydata$parameter == 5] = '6.interm_0'

mydata$monoRate = 1 - mydata$monoRate

# visualize data
# mydata$parameter = factor(mydata$parameter)
theme_set(theme_gray(base_size = 20))

################################################################################################
################################## Performance Overall #########################################
################################################################################################
overallData = mydata[,1:6]
meanOverallData = ddply(overallData,~parameter,summarise,ms=mean(meanSteps),mr=mean(monoRate),
                      cr=mean(compRate),ccr=mean(correctCompRate),sr=mean(skipRate))
seOverallData = ddply(overallData,~parameter,summarise,se_ms=se(meanSteps),se_mr=se(monoRate),
                      se_cr=se(compRate),se_ccr=se(correctCompRate),se_sr=se(skipRate))
meanOverallData = data.frame(meanOverallData, seOverallData[,2:ncol(seOverallData)])


# do the plotting 
limits = aes(ymax = ms + se_ms, ymin=ms - se_ms)
p1 = ggplot(meanOverallData, aes(x = parameter, y = ms, fill=parameter)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Mean number of steps used") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = cr + se_cr, ymin=cr - se_cr)
p2 = ggplot(meanOverallData, aes(x = parameter, y = cr, fill=parameter)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Completion rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = ccr + se_ccr, ymin=ccr - se_ccr)
p3 = ggplot(meanOverallData, aes(x = parameter, y = ccr, fill=parameter)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Correct completion rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

# multiplot(p1, p2, p3, cols=3)

limits = aes(ymax = mr + se_mr, ymin=mr - se_mr)
p4 = ggplot(meanOverallData, aes(x = parameter, y = mr, fill=parameter)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Order incorrect rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = sr + se_sr, ymin=sr - se_sr)
p5 = ggplot(meanOverallData, aes(x = parameter, y = sr, fill=parameter)) +
    geom_bar(stat="identity") +
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Skip rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank())



# multiplot(p4, p5, cols=2)

multiplot(p1, p2, p3, p4, p5, cols=3)
cat ("Press [enter] to continue")
line <- readline()



################################################################################################
################################## Performance by cardinality ##################################
################################################################################################


################################################################################################
# mean steps used by cardinality 
################################################################################################
tempSelectVars <- c('parameter',"steps1", "steps2", "steps3",
                    'steps4', 'steps5', 'steps6', 'steps7')
stepsData = mydata[tempSelectVars]
# compute mean by cardinality 
meanStepsData = ddply(stepsData,~parameter,summarise,one=mean(steps1),two=mean(steps2),
                      three=mean(steps3),four=mean(steps4),five=mean(steps5),six=mean(steps6),seven=mean(steps7))
seStepsData = ddply(stepsData,~parameter,summarise,one=se(steps1),two=se(steps2),
                      three=se(steps3),four=se(steps4),five=se(steps5),six=se(steps6),seven=se(steps7))
# gather data by cardinality
meanStepsData = gather(meanStepsData, cardinality, meanSteps, one:seven)
seStepsData = gather(seStepsData, cardinality, seSteps, one:seven)
# attach the se to the end of the data frame
meanStepsData <- data.frame(meanStepsData, seStepsData$seSteps)
colnames(meanStepsData)[ncol(meanStepsData)] = 'seSteps'
limits = aes(ymax = meanSteps + seSteps, ymin=meanSteps - seSteps)

# do the plotting 
p1 = ggplot(data=meanStepsData, aes(x=cardinality, y=meanSteps, group=parameter, colour=parameter)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 100) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean number of steps used") 


################################################################################################
# complete rate by cardinality 
################################################################################################
tempSelectVars <- c('parameter',"CR1", "CR2", "CR3",'CR4', 'CR5', 'CR6', 'CR7')
CRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanCRData = ddply(CRData,~parameter,summarise,one=mean(CR1),two=mean(CR2),
                   three=mean(CR3),four=mean(CR4),five=mean(CR5),six=mean(CR6),seven=mean(CR7))
seCRData = ddply(CRData,~parameter,summarise,one=se(CR1),two=se(CR2),
                    three=se(CR3),four=se(CR4),five=se(CR5),six=se(CR6),seven=se(CR7))
# gather data by cardinality
meanCRData = gather(meanCRData, cardinality, meanCR, one:seven)
seCRData = gather(seCRData, cardinality, seCR, one:seven)
# attach the se to the end of the data frame
meanCRData <- data.frame(meanCRData, seCRData$seCR)
colnames(meanCRData)[ncol(meanCRData)] = 'seCR'
limits = aes(ymax = meanCR + seCR, ymin=meanCR - seCR)

# do the plotting 
p2 = ggplot(data=meanCRData, aes(x=cardinality, y=meanCR, group=parameter, colour=parameter)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 1) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean completion rate")


################################################################################################
# correct complete rate by cardinality 
################################################################################################
tempSelectVars <- c('parameter',"CCR1", "CCR2", "CCR3",'CCR4', 'CCR5', 'CCR6', 'CCR7')
CCRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanCCRData = ddply(CCRData,~parameter,summarise,one=mean(CCR1),two=mean(CCR2),
                    three=mean(CCR3),four=mean(CCR4),five=mean(CCR5),six=mean(CCR6),seven=mean(CCR7))
seCCRData = ddply(CCRData,~parameter,summarise,one=se(CCR1),two=se(CCR2),
                 three=se(CCR3),four=se(CCR4),five=se(CCR5),six=se(CCR6),seven=se(CCR7))
# gather data by cardinality
meanCCRData = gather(meanCCRData, cardinality, meanCCR, one:seven)
seCCRData = gather(seCCRData, cardinality, seCCR, one:seven)

# attach the se to the end of the data frame
meanCCRData <- data.frame(meanCCRData, seCCRData$seCCR)
colnames(meanCCRData)[ncol(meanCCRData)] = 'seCCR'
limits = aes(ymax = meanCCR + seCCR, ymin=meanCCR - seCCR)

# do the plotting 
p3 = ggplot(data=meanCCRData, aes(x=cardinality, y=meanCCR, group=parameter, colour=parameter)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 1) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean correct completion rate")


# plot them all 
multiplot(p1, p2, p3, cols=2)
