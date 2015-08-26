plotBars <- function(data,parameter, mean, se) {
    
    limits = aes(ymax = mean + se, ymin= mean - se)
    ggplot(data, aes(x = parameter, y = mean, fill=parameter)) + 
        geom_bar(stat="identity") + 
        geom_errorbar(limits, width=0.15) + 
#         labs(x = xlabel, y = ylabel) + 
        theme(axis.text.x = element_blank(),axis.ticks = element_blank(), legend.position="none")
    
    
}