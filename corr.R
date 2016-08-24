corr <- function(directory, threshold=0){
    ## directory is a character vector of length 1 indicating 
    ## the location of the CSV files
    
    ##threshold is a numeric vector of length 1 indicating the
    ##number of completely observed observations (on all variables)
    ##required to compute the correlation between
    ## nitrate and sulfate; the default value is 0
    
    ##This functions returns a numeric vector of correlations
    
    ##Read number of complete cases from directory
    dataComplete <- complete(directory)
    nrows <- nrow(dataComplete)
    
    ## Extract the monitors' id with number of complete observations 
    ## greater than threshold
    enoughComplete <- c()
    for (i in 1:nrows){ 
        if (dataComplete[i,"nobs"] > threshold){
            enoughComplete <- c(enoughComplete,dataComplete[i,"ids"])
        }
    }
    
    ## ## Compute correlationfor each file with enough complete observations
    nrowsEnough <- length(enoughComplete)
    results <- c()
    if (nrowsEnough > 0){
        for (i in 1:nrowsEnough){
            filename <- paste0(directory,"/", formatC(enoughComplete[i], width=3,flag="0"), ".csv")
            data <- read.csv(filename)
            results <- c(results, cor(x=data[,"sulfate"],y=data[,"nitrate"],use="pairwise.complete.obs"))
        }
    }
    else{
        results <- 0
    }
    results
}