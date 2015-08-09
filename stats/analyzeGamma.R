# analyze the relation between gamma values and model performance
rm(list = ls())
library(ggplot2)
source('multiplot.R')
# load data
setwd('/Users/Qihong/Dropbox/github/mathCognition/stats')
mydata = read.csv('gammaData.csv', header = F)
colnames(mydata) = c('gamma', 'meanSteps', 'monoRate', 'compRate', 'skipRate', 'steps1', 'steps2', 'steps3', 'steps4', 'steps5', 'steps6', 'steps7')

# visualize data
p1 = ggplot(mydata, aes(x=gamma, y=meanSteps)) + 
    geom_point(aes(color=factor(gamma))) + 
    geom_smooth()  
p2 = ggplot(mydata, aes(x=gamma, y=monoRate)) + 
    geom_point(aes(color=factor(gamma))) + 
    geom_smooth()  
p3 = ggplot(mydata, aes(x=gamma, y=compRate)) + 
    geom_point(aes(color=factor(gamma))) + 
    geom_smooth()  
p4 = ggplot(mydata, aes(x=gamma, y=skipRate)) + 
    geom_point(aes(color=factor(gamma))) + 
    geom_smooth()  
multiplot(p1, p2, p3, p4, cols=2)