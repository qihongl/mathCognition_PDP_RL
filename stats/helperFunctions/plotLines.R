plotLines <- function(x) {
    
    tempSelectVars <- c('teachModes',genNameByCard('steps',maxNumItems))
    stepsData = mydata[tempSelectVars]
    # compute mean by cardinality 
    meanStepsData = ddply(stepsData,~teachModes,summarise,one=mean(steps1),two=mean(steps2),
                          three=mean(steps3),four=mean(steps4),five=mean(steps5),six=mean(steps6),
                          seven=mean(steps7), eight=mean(steps8),nine=mean(steps9),ten=mean(steps10))
    seStepsData = ddply(stepsData,~teachModes,summarise,one=se(steps1),two=se(steps2),
                        three=se(steps3),four=se(steps4),five=se(steps5),six=se(steps6),seven=se(steps7),
                        eight=se(steps8),nine=se(steps9),ten=se(steps10))
    # gather data by cardinality
    meanStepsData = gather(meanStepsData, cardinality, meanSteps, one:ten)
    seStepsData = gather(seStepsData, cardinality, seSteps, one:ten)
    # attach the se to the end of the data frame
    meanStepsData <- data.frame(meanStepsData, seStepsData$seSteps)
    colnames(meanStepsData)[ncol(meanStepsData)] = 'seSteps'
    limits = aes(ymax = meanSteps + seSteps, ymin=meanSteps - seSteps)
    
    # do the plotting 
    p1 = ggplot(data=meanStepsData, aes(x=cardinality, y=meanSteps, group=teachModes, colour=teachModes)) +
        geom_line(size = 1.25) + geom_point() + ylim(0, 100) +  
        geom_errorbar(limits, width=0.15) + 
        labs(x = "Number of items", y = "Mean number of steps used") 
    
}