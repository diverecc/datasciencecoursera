## rankall that takes two arguments: an outcome name (outcome) and 
## a hospital ranking(num). 
## The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
## containing the hospital in each state that has the ranking specified in num. For example the function call
## rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
## are the best in their respective states for 30-day heart attack death rates

rankall <- function(outcome, num = "best") {
    ## Build up a reference to the 30-day mortality rate column per outcome
    ## mortality[i] is for outcomes[i]
    outcomes <- c("heart attack","heart failure","pneumonia")
    mortalities <- data.frame(name=outcomes,value=c(11,17,23))
    
    ##check validity of outcome
    if (outcome %in%  outcomes == FALSE){
        stop("invalid outcome")
    }
    mfield <- mortalities[which(mortalities$name==outcome),]$value
    
    ## Read outcome data
    data  <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    states <-unique(data$State)
    states <- states[order(states)]
    h <- c()
    s <- c()
    for (i in 1:length(states)) {
        ## Extract hospitals in that state with valid data for outcome
        hospitals <- subset(data,State==states[i] & data[[mfield]]!="Not Available", select=c(Hospital.Name,mfield))
        
        ## Sort hospitals by their values then their names within this state
        hospitals[,2] <- as.numeric(hospitals[,2])
        rankedhospitals <- hospitals[order(hospitals[,2],hospitals[,1]),]
        
        ## store hospital name at rank num with its state
        if (num=="best" ) {
            numi <- 1
        }
        else if (num=="worst"){
            numi <- nrow(hospitals)
        }
        else {
            numi <- as.numeric(num)
        }
        h <- c(h, rankedhospitals[numi,1])
        s <- c(s, states[i])
    }
    result <- data.frame(hospital=h,state=s)
}