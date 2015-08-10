# analyze the relation between parameter values and model performance
rm(list = ls())
library(ggplot2)
source('multiplot.R')
# load data
setwd('/Users/Qihong/Dropbox/github/mathCognition/stats')
mydata = read.csv('punFacData.csv', header = F)
colnames(mydata) = c('parameter', 'meanSteps', 'monoRate', 'compRate', 'correctCompRate', 'skipRate',
                     'steps1', 'steps2', 'steps3', 'steps4', 'steps5', 'steps6', 'steps7',
                     'CR1','CR2','CR3','CR4','CR5','CR6','CR7',
                     'CCR1','CCR2','CCR3','CCR4','CCR5','CCR6','CCR7')

# visualize data
p1 = ggplot(mydata, aes(x=parameter, y=meanSteps)) + 
    geom_point(aes(parameter)) + 
    geom_smooth() 
#     labs(x = "punnishFactorDecrementRate", y = "mean steps used")
p2 = ggplot(mydata, aes(x=parameter, y=monoRate)) + 
    geom_point(aes(parameter)) + 
    geom_smooth() 
#     labs(x = "punnishFactorDecrementRate", y = "monotonic rate")
p3 = ggplot(mydata, aes(x=parameter, y=compRate)) + 
    geom_point(aes(parameter)) + 
    geom_smooth()  
p4 = ggplot(mydata, aes(x=parameter, y=correctCompRate)) + 
    geom_point(aes(parameter)) + 
    geom_smooth()  
p5 = ggplot(mydata, aes(x=parameter, y=skipRate)) + 
    geom_point(aes(parameter)) + 
    geom_smooth()  

multiplot(p1, p2, p3, p4, p5, cols=2)
cat ("Press [enter] to continue")
line <- readline()

# mean steps used by cardinality 
p1 = ggplot(mydata, aes(x=parameter, y=steps1)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  
p2 = ggplot(mydata, aes(x=parameter, y=steps2)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  
p3 = ggplot(mydata, aes(x=parameter, y=steps3)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  
p4 = ggplot(mydata, aes(x=parameter, y=steps4)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  
p5 = ggplot(mydata, aes(x=parameter, y=steps5)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  
p6 = ggplot(mydata, aes(x=parameter, y=steps6)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  
p7 = ggplot(mydata, aes(x=parameter, y=steps7)) + 
    geom_point(aes(parameter)) + ylim(0, 100) +  
    geom_smooth()  

p8 = ggplot(mydata) + 
    geom_smooth(aes(parameter,steps1), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,steps2), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,steps3), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,steps4), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,steps5), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,steps6), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,steps7), colour="blue", se=TRUE) + 
    ylim(0, 100) +  
    labs(x = "parameter", y = "Number of steps used on average")


multiplot(p1, p2, p3, p4, p5, p6, p7, p8, cols=3)
cat ("Press [enter] to continue")
line <- readline()




# complete rate by cardinality 
p1 = ggplot(mydata, aes(x=parameter, y=CR1)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p2 = ggplot(mydata, aes(x=parameter, y=CR2)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p3 = ggplot(mydata, aes(x=parameter, y=CR3)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p4 = ggplot(mydata, aes(x=parameter, y=CR4)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p5 = ggplot(mydata, aes(x=parameter, y=CR5)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p6 = ggplot(mydata, aes(x=parameter, y=CR6)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p7 = ggplot(mydata, aes(x=parameter, y=CR7)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  

p8 = ggplot(mydata) + 
    geom_smooth(aes(parameter,CR1), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CR2), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CR3), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CR4), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CR5), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CR6), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CR7), colour="blue", se=TRUE) + 
    ylim(0, 1) +  
    labs(x = "parameter", y = "Complete rate")


multiplot(p1, p2, p3, p4, p5, p6, p7, p8, cols=3)
cat ("Press [enter] to continue")
line <- readline()





# correct complete rate by cardinality 
p1 = ggplot(mydata, aes(x=parameter, y=CCR1)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p2 = ggplot(mydata, aes(x=parameter, y=CCR2)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p3 = ggplot(mydata, aes(x=parameter, y=CCR3)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p4 = ggplot(mydata, aes(x=parameter, y=CCR4)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p5 = ggplot(mydata, aes(x=parameter, y=CCR5)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p6 = ggplot(mydata, aes(x=parameter, y=CCR6)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  
p7 = ggplot(mydata, aes(x=parameter, y=CCR7)) + 
    geom_point(aes(parameter)) + ylim(0, 1) +  
    geom_smooth()  

p8 = ggplot(mydata) + 
    geom_smooth(aes(parameter,CCR1), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CCR2), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CCR3), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CCR4), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CCR5), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CCR6), colour="blue", se=TRUE) + 
    geom_smooth(aes(parameter,CCR7), colour="blue", se=TRUE) + 
    ylim(0, 1) +  
    labs(x = "parameter", y = "Correct complete rate")


multiplot(p1, p2, p3, p4, p5, p6, p7, p8, cols=3)