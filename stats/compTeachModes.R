# Compare the performance across different ways of teaching
rm(list = ls())
library(ggplot2); library(plyr); library(tidyr); library(dplyr)
setwd('/Users/Qihong/Dropbox/github/mathCognition/stats')
source('helperFunctions/multiplot.R'); source('helperFunctions/se.R');
# source('helperFunctions/plotBars.R')
# load data
mydata = read.csv('moreTrain.csv', header = F)

################################################################################################
################################## Preprocess the data #########################################
################################################################################################
# set the name (need to be revised when adding new variables!)
numOverallData = 8; 
colnames(mydata) = c('teachModes', 'meanSteps', 'monoRate', 'compRate', 'correctCompRate',
                     'skipRate','stopEarlyRate', 'numDoubleTouch',
                     'steps1', 'steps2', 'steps3', 'steps4', 'steps5', 'steps6', 'steps7',
                     'CR1','CR2','CR3','CR4','CR5','CR6','CR7',
                     'CCR1','CCR2','CCR3','CCR4','CCR5','CCR6','CCR7',
                     'SR1','SR2','SR3','SR4','SR5','SR6','SR7',
                     'SER1','SER2','SER3','SER4','SER5','SER6','SER7',
                     'numErr1','numErr2','numErr3','numErr4','numErr5','numErr6','numErr7',
                     'DT1','DT2','DT3','DT4','DT5','DT6','DT7')

# set the condition label (need to be revised when changing conditions!)
mydata$teachModes[mydata$teachModes == 0] = '1.finalRwdOnly'
mydata$teachModes[mydata$teachModes == 1] = '2.interm'
mydata$teachModes[mydata$teachModes == 2] = '3.demon'
mydata$teachModes[mydata$teachModes == 3] = '4.demon+interm'

# convert correct rate to error rate
mydata$monoRate = 1 - mydata$monoRate
# set the font size
theme_set(theme_gray(base_size = 20))

################################################################################################
################################## Performance Overall #########################################
################################################################################################
overallData = mydata[,1:numOverallData]
meanOverallData = ddply(overallData,~teachModes,summarise,ms=mean(meanSteps),mr=mean(monoRate),
                      cr=mean(compRate),ccr=mean(correctCompRate),sr=mean(skipRate), 
                      ser = mean(stopEarlyRate), dt = mean(numDoubleTouch))
seOverallData = ddply(overallData,~teachModes,summarise,se_ms=se(meanSteps),se_mr=se(monoRate),
                      se_cr=se(compRate),se_ccr=se(correctCompRate),se_sr=se(skipRate), 
                      se_ser = se(stopEarlyRate), se_dt = se(numDoubleTouch))
meanOverallData = data.frame(meanOverallData, seOverallData[,2:ncol(seOverallData)])

# do the plotting 
limits = aes(ymax = ms + se_ms, ymin=ms - se_ms)
p1 = ggplot(meanOverallData, aes(x = teachModes, y = ms, fill=teachModes)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Mean number of steps used") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = cr + se_cr, ymin=cr - se_cr)
p2 = ggplot(meanOverallData, aes(x = teachModes, y = cr, fill=teachModes)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Completion rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = ccr + se_ccr, ymin=ccr - se_ccr)
p3 = ggplot(meanOverallData, aes(x = teachModes, y = ccr, fill=teachModes)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Correct completion rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = mr + se_mr, ymin=mr - se_mr)
p4 = ggplot(meanOverallData, aes(x = teachModes, y = mr, fill=teachModes)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Order incorrect rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = sr + se_sr, ymin=sr - se_sr)
p5 = ggplot(meanOverallData, aes(x = teachModes, y = sr, fill=teachModes)) +
    geom_bar(stat="identity") +
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Skip rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")


limits = aes(ymax = ser + se_ser, ymin=ser - se_ser)
p6 = ggplot(meanOverallData, aes(x = teachModes, y = ser, fill=teachModes)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Mean stop early rate") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

limits = aes(ymax = dt + se_dt, ymin=dt - se_dt)
p7 = ggplot(meanOverallData, aes(x = teachModes, y = dt, fill=teachModes)) + 
    geom_bar(stat="identity") + 
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Teaching mode", y = "Mean number of double touching") + 
    theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")

multiplot(p1, p2, p3, p4, p5, p6, p7, cols=3)
cat ("Press [enter] to continue")
line <- readline()



################################################################################################
################################## Performance by cardinality ##################################
################################################################################################


################################################################################################
# mean steps used by cardinality 
################################################################################################
tempSelectVars <- c('teachModes',"steps1", "steps2", "steps3",
                    'steps4', 'steps5', 'steps6', 'steps7')
stepsData = mydata[tempSelectVars]
# compute mean by cardinality 
meanStepsData = ddply(stepsData,~teachModes,summarise,one=mean(steps1),two=mean(steps2),
                      three=mean(steps3),four=mean(steps4),five=mean(steps5),six=mean(steps6),seven=mean(steps7))
seStepsData = ddply(stepsData,~teachModes,summarise,one=se(steps1),two=se(steps2),
                      three=se(steps3),four=se(steps4),five=se(steps5),six=se(steps6),seven=se(steps7))
# gather data by cardinality
meanStepsData = gather(meanStepsData, cardinality, meanSteps, one:seven)
seStepsData = gather(seStepsData, cardinality, seSteps, one:seven)
# attach the se to the end of the data frame
meanStepsData <- data.frame(meanStepsData, seStepsData$seSteps)
colnames(meanStepsData)[ncol(meanStepsData)] = 'seSteps'
limits = aes(ymax = meanSteps + seSteps, ymin=meanSteps - seSteps)

# do the plotting 
p1 = ggplot(data=meanStepsData, aes(x=cardinality, y=meanSteps, group=teachModes, colour=teachModes)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 100) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean number of steps used") 


################################################################################################
# complete rate by cardinality 
################################################################################################
tempSelectVars <- c('teachModes',"CR1", "CR2", "CR3",'CR4', 'CR5', 'CR6', 'CR7')
CRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanCRData = ddply(CRData,~teachModes,summarise,one=mean(CR1),two=mean(CR2),
                   three=mean(CR3),four=mean(CR4),five=mean(CR5),six=mean(CR6),seven=mean(CR7))
seCRData = ddply(CRData,~teachModes,summarise,one=se(CR1),two=se(CR2),
                    three=se(CR3),four=se(CR4),five=se(CR5),six=se(CR6),seven=se(CR7))
# gather data by cardinality
meanCRData = gather(meanCRData, cardinality, meanCR, one:seven)
seCRData = gather(seCRData, cardinality, seCR, one:seven)
# attach the se to the end of the data frame
meanCRData <- data.frame(meanCRData, seCRData$seCR)
colnames(meanCRData)[ncol(meanCRData)] = 'seCR'
limits = aes(ymax = meanCR + seCR, ymin=meanCR - seCR)

# do the plotting 
p2 = ggplot(data=meanCRData, aes(x=cardinality, y=meanCR, group=teachModes, colour=teachModes)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 1) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean completion rate")


################################################################################################
# correct complete rate by cardinality 
################################################################################################
tempSelectVars <- c('teachModes',"CCR1", "CCR2", "CCR3",'CCR4', 'CCR5', 'CCR6', 'CCR7')
CCRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanCCRData = ddply(CCRData,~teachModes,summarise,one=mean(CCR1),two=mean(CCR2),
                    three=mean(CCR3),four=mean(CCR4),five=mean(CCR5),six=mean(CCR6),seven=mean(CCR7))
seCCRData = ddply(CCRData,~teachModes,summarise,one=se(CCR1),two=se(CCR2),
                 three=se(CCR3),four=se(CCR4),five=se(CCR5),six=se(CCR6),seven=se(CCR7))
# gather data by cardinality
meanCCRData = gather(meanCCRData, cardinality, meanCCR, one:seven)
seCCRData = gather(seCCRData, cardinality, seCCR, one:seven)

# attach the se to the end of the data frame
meanCCRData <- data.frame(meanCCRData, seCCRData$seCCR)
colnames(meanCCRData)[ncol(meanCCRData)] = 'seCCR'
limits = aes(ymax = meanCCR + seCCR, ymin=meanCCR - seCCR)

# do the plotting 
p3 = ggplot(data=meanCCRData, aes(x=cardinality, y=meanCCR, group=teachModes, colour=teachModes)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 1) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean correct completion rate")



################################################################################################
# skip rate by cardinality 
################################################################################################
tempSelectVars <- c('teachModes',"SR1", "SR2", "SR3",'SR4', 'SR5', 'SR6', 'SR7')
SRData = mydata[tempSelectVars]
# compute mean by cardinality 
meanSRData = ddply(SRData,~teachModes,summarise,one=mean(SR1),two=mean(SR2),
                    three=mean(SR3),four=mean(SR4),five=mean(SR5),six=mean(SR6),seven=mean(SR7))
seSRData = ddply(SRData,~teachModes,summarise,one=se(SR1),two=se(SR2),
                  three=se(SR3),four=se(SR4),five=se(SR5),six=se(SR6),seven=se(SR7))
# gather data by cardinality
meanSRData = gather(meanSRData, cardinality, meanSR, one:seven)
seSRData = gather(seSRData, cardinality, seSR, one:seven)

# attach the se to the end of the data frame
meanSRData <- data.frame(meanSRData, seSRData$seSR)
colnames(meanSRData)[ncol(meanSRData)] = 'seSR'
limits = aes(ymax = meanSR + seSR, ymin=meanSR - seSR)

# do the plotting 
p4 = ggplot(data=meanSRData, aes(x=cardinality, y=meanSR, group=teachModes, colour=teachModes)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 1) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean skip rate")


################################################################################################
# stop early rate by cardinality 
################################################################################################
tempSelectVars <- c('teachModes',"SER1", "SER2", "SER3",'SER4', 'SER5', 'SER6', 'SER7')
SERData = mydata[tempSelectVars]
# compute mean by cardinality 
meanSERData = ddply(SERData,~teachModes,summarise,one=mean(SER1),two=mean(SER2),
                   three=mean(SER3),four=mean(SER4),five=mean(SER5),six=mean(SER6),seven=mean(SER7))
seSERData = ddply(SERData,~teachModes,summarise,one=se(SER1),two=se(SER2),
                 three=se(SER3),four=se(SER4),five=se(SER5),six=se(SER6),seven=se(SER7))
# gather data by cardinality
meanSERData = gather(meanSERData, cardinality, meanSER, one:seven)
seSERData = gather(seSERData, cardinality, seSER, one:seven)

# attach the se to the end of the data frame
meanSERData <- data.frame(meanSERData, seSERData$seSER)
colnames(meanSERData)[ncol(meanSERData)] = 'seSER'
limits = aes(ymax = meanSER + seSER, ymin=meanSER - seSER)

# do the plotting 
p5 = ggplot(data=meanSERData, aes(x=cardinality, y=meanSER, group=teachModes, colour=teachModes)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, 1) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean stop early rate")


################################################################################################
# mean number of double touching by cardinality 
################################################################################################
tempSelectVars <- c('teachModes',"DT1", "DT2", "DT3",'DT4', 'DT5', 'DT6', 'DT7')
DTData = mydata[tempSelectVars]
# compute mean by cardinality 
meanDTData = ddply(DTData,~teachModes,summarise,one=mean(DT1),two=mean(DT2),
                    three=mean(DT3),four=mean(DT4),five=mean(DT5),six=mean(DT6),seven=mean(DT7))
seDTData = ddply(DTData,~teachModes,summarise,one=se(DT1),two=se(DT2),
                  three=se(DT3),four=se(DT4),five=se(DT5),six=se(DT6),seven=se(DT7))
# gather data by cardinality
meanDTData = gather(meanDTData, cardinality, meanDT, one:seven)
seDTData = gather(seDTData, cardinality, seDT, one:seven)

# attach the se to the end of the data frame
meanDTData <- data.frame(meanDTData, seDTData$seDT)
colnames(meanDTData)[ncol(meanDTData)] = 'seDT'
limits = aes(ymax = meanDT + seDT, ymin=meanDT - seDT)

# do the plotting 
p6 = ggplot(data=meanDTData, aes(x=cardinality, y=meanDT, group=teachModes, colour=teachModes)) +
    geom_line(size = 1.25) + geom_point() + ylim(0, ceiling(max(meanDTData$meanDT + meanDTData$seDT))) +  
    geom_errorbar(limits, width=0.15) + 
    labs(x = "Number of items", y = "Mean number of double touches")


# plot them all 
multiplot(p1, p2, p3, p4, p5, p6, cols=2)
