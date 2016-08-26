## The function best() The function reads the outcome-of-care-measures.csv file and 
## returns a character vector with the name of the hospital that has 
## the best (i.e. lowest) 30-day mortality for the specified outcome in that state. 

best <- function(state, outcome) {
    ## state is the 2-character abbreviated name of a state. 
    ## outcome is one of the following string: "heart attack", "heart failure", or "pneumonia"
    ## If an invalid state value is passed to best, the
    ## Check that outcome is valid before reading the data file
    outcomes <- c("heart attack","heart failure","pneumonia")
    if (outcome %in%  outcomes == FALSE){
        stop("invalid outcome")
    }
    ## Read outcome data
    data  <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state is valid against the state column
    if (state %in% data[,"State"] == FALSE){
        stop("invalid state")
    }
    ## Build up a reference to the 30-day mortality rate column per outcome
    ## mortality[i] is for outcomes[i]
    mortalities <- data.frame(name=outcomes,value=c(11,17,23))
    
    ## Extract hospitals in that state with valid data for outcome 
    mfield <- mortalities[which(mortalities$name==outcome),]$value
    hospitals <- subset(data,State==state & data[[mfield]]!="Not Available", select=c(Hospital.Name,mfield))

    ## Return the first hospital name in that state with lowest 30-day death rate 
    ## (in alphabetic order)
    besthospitals <- hospitals[which.min(as.numeric(hospitals[,2])),]
    besthospitals <- besthospitals[order(1),]
    besthospitals[1,]$Hospital.Name
}
