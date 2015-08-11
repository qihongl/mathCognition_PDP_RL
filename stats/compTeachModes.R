# analyze the relation between parameter values and model performance
rm(list = ls())
library(ggplot2); library(plyr); library(tidyr); library(dplyr)
source('multiplot.R'); source('se.R')
# load data
setwd('/Users/Qihong/Dropbox/github/mathCognition/stats')
mydata = read.csv('compTeach2.csv', header = F)
colnames(mydata) = c('parameter', 'meanSteps', 'monoRate', 'compRate', 'correctCompRate', 'skipRate',
                     'steps1', 'steps2', 'steps3', 'steps4', 'steps5', 'steps6', 'steps7',
                     'CR1','CR2','CR3','CR4','CR5','CR6','CR7',
                     'CCR1','CCR2','CCR3','CCR4','CCR5','CCR6','CCR7')
mydata$parameter[mydata$parameter == 0] = 'finalRwdOnly'
mydata$parameter[mydata$parameter == 1] = 'interm'
mydata$parameter[mydata$parameter == 2] = 'interm+PF'
mydata$parameter[mydata$parameter == 3] = 'tForcing'
mydata$parameter[mydata$parameter == 4] = 'tForcing+interm'

# visualize data
# TODO : use bar plot perhaps
# mydata$parameter = factor(mydata$parameter)


################################################################################################
################################## Performance Overall #########################################
################################################################################################
overallData = mydata[,1:6]
meanOverallData = ddply(overallData,~parameter,summarise,ms=mean(meanSteps),mr=mean(monoRate),
                      cr=mean(compRate),ccr=mean(correctCompRate),sr=mean(skipRate))

p1 = ggplot(meanOverallData, aes(x = parameter, y = ms, fill=parameter)) + 
    geom_bar(stat="identity") + theme(legend.position="none") + 
    labs(x = "Teaching mode", y = "Number of steps used on average")
p2 = ggplot(meanOverallData, aes(x = parameter, y = mr, fill=parameter)) + 
    geom_bar(stat="identity") + theme(legend.position="none") + 
    labs(x = "Teaching mode", y = "Monotonic rate")
p3 = ggplot(meanOverallData, aes(x = parameter, y = cr, fill=parameter)) + 
    geom_bar(stat="identity") + theme(legend.position="none") + 
    labs(x = "Teaching mode", y = "Completion rate")
p4 = ggplot(meanOverallData, aes(x = parameter, y = ccr, fill=parameter)) + 
    geom_bar(stat="identity") + theme(legend.position="none") + 
    labs(x = "Teaching mode", y = "Correct completion rate")
p5 = ggplot(meanOverallData, aes(x = parameter, y = sr, fill=parameter)) +
    geom_bar(stat="identity") + theme(legend.position="none") + 
    labs(x = "Teaching mode", y = "Skip rate")
multiplot(p1, p2, p3, p4, p5, cols=2)
cat ("Press [enter] to continue")
line <- readline()



################################################################################################
################################## Performance by cardinality ##################################
################################################################################################
# mean steps used by cardinality 
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

p1 = ggplot(data=meanStepsData, aes(x=cardinality, y=meanSteps, group=parameter, colour=parameter)) +
    geom_line() + geom_point() + ylim(0, 100) +  
    labs(x = "Number of items", y = "Number of steps used on average")



# complete rate by cardinality 
tempSelectVars <- c('parameter',"CR1", "CR2", "CR3",'CR4', 'CR5', 'CR6', 'CR7')
CRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanCRData = ddply(CRData,~parameter,summarise,one=mean(CR1),two=mean(CR2),
                   three=mean(CR3),four=mean(CR4),five=mean(CR5),six=mean(CR6),seven=mean(CR7))
# gather data by cardinality
meanCRData = gather(meanCRData, cardinality, meanCR, one:seven)

p2 = ggplot(data=meanCRData, aes(x=cardinality, y=meanCR, group=parameter, colour=parameter)) +
    geom_line() + geom_point() + ylim(0, 1) +  
    labs(x = "Number of items", y = "Mean completion rate")



# correct complete rate by cardinality 
tempSelectVars <- c('parameter',"CCR1", "CCR2", "CCR3",'CCR4', 'CCR5', 'CCR6', 'CCR7')
CCRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanCCRData = ddply(CCRData,~parameter,summarise,one=mean(CCR1),two=mean(CCR2),
                    three=mean(CCR3),four=mean(CCR4),five=mean(CCR5),six=mean(CCR6),seven=mean(CCR7))
# gather data by cardinality
meanCCRData = gather(meanCCRData, cardinality, meanCCR, one:seven)

p3 = ggplot(data=meanCCRData, aes(x=cardinality, y=meanCCR, group=parameter, colour=parameter)) +
    geom_line() + geom_point() + ylim(0, 1) +  
    labs(x = "Number of items", y = "Mean correct completion rate")

# plot them all 
multiplot(p1, p2, p3, cols=3)
