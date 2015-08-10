# analyze the relation between gamma values and model performance
rm(list = ls())
library(ggplot2)
source('multiplot.R')
# load data
setwd('/Users/Qihong/Dropbox/github/mathCognition/stats')
mydata = read.csv('gammaData.csv', header = F)
colnames(mydata) = c('gamma', 'meanSteps', 'monoRate', 'compRate', 'correctCompRate', 'skipRate',
                     'steps1', 'steps2', 'steps3', 'steps4', 'steps5', 'steps6', 'steps7',
                     'CR1','CR2','CR3','CR4','CR5','CR6','CR7',
                     'CCR1','CCR2','CCR3','CCR4','CCR5','CCR6','CCR7')

# visualize data
p1 = ggplot(mydata, aes(x=gamma, y=meanSteps)) + 
    geom_point(aes(gamma)) + 
    geom_smooth()  
p2 = ggplot(mydata, aes(x=gamma, y=monoRate)) + 
    geom_point(aes(gamma)) + 
    geom_smooth()  
p3 = ggplot(mydata, aes(x=gamma, y=compRate)) + 
    geom_point(aes(gamma)) + 
    geom_smooth()  
p4 = ggplot(mydata, aes(x=gamma, y=correctCompRate)) + 
    geom_point(aes(gamma)) + 
    geom_smooth()  
p5 = ggplot(mydata, aes(x=gamma, y=skipRate)) + 
    geom_point(aes(gamma)) + 
    geom_smooth()  

multiplot(p1, p2, p3, p4, p5, cols=2)
cat ("Press [enter] to continue")
line <- readline()

# mean steps used by cardinality 
p1 = ggplot(mydata, aes(x=gamma, y=steps1)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  
p2 = ggplot(mydata, aes(x=gamma, y=steps2)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  
p3 = ggplot(mydata, aes(x=gamma, y=steps3)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  
p4 = ggplot(mydata, aes(x=gamma, y=steps4)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  
p5 = ggplot(mydata, aes(x=gamma, y=steps5)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  
p6 = ggplot(mydata, aes(x=gamma, y=steps6)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  
p7 = ggplot(mydata, aes(x=gamma, y=steps7)) + 
    geom_point(aes(gamma)) + ylim(0, 100) +  
    geom_smooth()  

p8 = ggplot(mydata) + 
    geom_smooth(aes(gamma,steps1), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,steps2), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,steps3), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,steps4), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,steps5), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,steps6), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,steps7), colour="blue", se=TRUE) + 
    ylim(0, 100) +  
    labs(x = "gamma", y = "Number of steps used on average")


multiplot(p1, p2, p3, p4, p5, p6, p7, p8, cols=3)
cat ("Press [enter] to continue")
line <- readline()




# complete rate by cardinality 
p1 = ggplot(mydata, aes(x=gamma, y=CR1)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p2 = ggplot(mydata, aes(x=gamma, y=CR2)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p3 = ggplot(mydata, aes(x=gamma, y=CR3)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p4 = ggplot(mydata, aes(x=gamma, y=CR4)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p5 = ggplot(mydata, aes(x=gamma, y=CR5)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p6 = ggplot(mydata, aes(x=gamma, y=CR6)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p7 = ggplot(mydata, aes(x=gamma, y=CR7)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  

p8 = ggplot(mydata) + 
    geom_smooth(aes(gamma,CR1), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CR2), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CR3), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CR4), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CR5), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CR6), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CR7), colour="blue", se=TRUE) + 
    ylim(0, 1) +  
    labs(x = "gamma", y = "Complete rate")


multiplot(p1, p2, p3, p4, p5, p6, p7, p8, cols=3)
cat ("Press [enter] to continue")
line <- readline()





# correct complete rate by cardinality 
p1 = ggplot(mydata, aes(x=gamma, y=CCR1)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p2 = ggplot(mydata, aes(x=gamma, y=CCR2)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p3 = ggplot(mydata, aes(x=gamma, y=CCR3)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p4 = ggplot(mydata, aes(x=gamma, y=CCR4)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p5 = ggplot(mydata, aes(x=gamma, y=CCR5)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p6 = ggplot(mydata, aes(x=gamma, y=CCR6)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  
p7 = ggplot(mydata, aes(x=gamma, y=CCR7)) + 
    geom_point(aes(gamma)) + ylim(0, 1) +  
    geom_smooth()  

p8 = ggplot(mydata) + 
    geom_smooth(aes(gamma,CCR1), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CCR2), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CCR3), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CCR4), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CCR5), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CCR6), colour="blue", se=TRUE) + 
    geom_smooth(aes(gamma,CCR7), colour="blue", se=TRUE) + 
    ylim(0, 1) +  
    labs(x = "gamma", y = "Correct complete rate")


multiplot(p1, p2, p3, p4, p5, p6, p7, p8, cols=3)