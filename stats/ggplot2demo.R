rm(list = ls())
library(ggplot2); library(plyr); library(tidyr); library(dplyr)

df <- data.frame(
    cardinality = factor(c(1, 1, 2, 2)),
    mean = c(1, 5, 3, 4),
    tMode = factor(c(1, 2, 1, 2)),
    se = c(0.1, 0.3, 0.3, 0.2)
)

# Define the top and bottom of the errorbars
limits = aes(ymax = mean + se, ymin=mean - se)
dodge = position_dodge(width=0.9)

ggplot(df, aes(fill=tMode, y=mean, x=cardinality)) + 
    geom_bar(position="dodge", stat="identity") + 
    geom_errorbar(limits, position=dodge, width=0.25)

