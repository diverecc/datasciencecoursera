pollutantmean <- function(directory, pollutant, id=1:332){
    ## directory is a character vector of length 1 indicating 
    ## the location of the CSV files
    
    ## pollutant is a character vector of length 1 indicating 
    ## the name of the pollutant fo which we will calculate the
    ## mean;
    
    ## id is an integer vector indicating the monitor ID numbers
    ## to be used.
    
    ## The function returns the mean of the pollutant across all monitors list
    ## in the id vector (ignoring NA values)
    
    traceFlag <- F
    dataformean <- c()
    i <- 1
    l <- length(id)
    while (i <= l) {
        ## format the filename
        filename <- paste0(directory,"/", formatC(id[i], width=3,flag="0"), ".csv") 
        if (traceFlag) {print(filename)}
        
        ##  read "xxx.csv" file
        data <- read.csv(filename) 
        
        ## eliminate NA from the vector
        iformean <- data[,pollutant]
        iformean <-iformean[!is.na(iformean)]
        if (traceFlag) {print(iformean)}
        
        ## aggregate the column pollutant for monitor i
        dataformean <- c(dataformean, iformean)
        if (traceFlag) {print(dataformean)}
        
        i <- i+1
    }
    ## compute the mean for pollutant  across all monitors listed in id
    mean(dataformean)
}
