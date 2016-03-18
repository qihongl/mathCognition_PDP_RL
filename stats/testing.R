library(ggplot2)
# Automatic levels
mtcars
ggplot(mtcars, aes(factor(cyl))) + geom_bar()  


# Manual levels
cyl_table <- table(mtcars$cyl)
cyl_levels <- names(cyl_table)[order(cyl_table)]
mtcars$cyl2 <- factor(mtcars$cyl, levels = cyl_levels)
# Just to be clear, the above line is no different than:
# mtcars$cyl2 <- factor(mtcars$cyl, levels = c("6","4","8"))
# You can manually set the levels in whatever order you please. 
ggplot(mtcars, aes(cyl2)) + geom_bar()


mtcars$cyl3 <- with(mtcars, reorder(cyl, cyl, function(x) -length(x)))
ggplot(mtcars, aes(cyl3)) + geom_bar()