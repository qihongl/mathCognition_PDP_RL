genNameByCard <- function(name, maxNumItems) {
    # preallocate
    nameByCards = vector(length = maxNumItems)
    # generate the names in the order to cardinality 
    for (i in 1:maxNumItems){
        nameByCards[i] = paste(name, toString(i), sep ='')
    }
    return(nameByCards)
}