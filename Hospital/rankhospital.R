## The function rankhospital that takes three arguments: the 2-character abbreviated name of a
## state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
## The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
## of the hospital that has the ranking specified by the num argument

## NOTE - in order to minimize read operations, the global variable "hospitals" from the function best() 
## is used. Please refer to function best() for its definition
##
rankhospital <- function(state, outcome, num = "best") {
    
    hospitals <<- data.frame(c(),c())
    
    ## Populate hospitals with the function best()
    best(state,outcome)
    
    ## Sort hospitals by their values then their names
    hospitals[,2] <- as.numeric(hospitals[,2])
    rankedhospitals <- hospitals[order(hospitals[,2],hospitals[,1]),]
    
    ## return hospital name at rank num
    if (num=="best" )
        num <- 1
    else if (num=="worst"){
        num <- nrow(rankedhospitals)
    }
    else
        num <- as.numeric(num)

    r <- rankedhospitals[num,1]
    r
}
