complete <- function(directory, id=1:332){
    ## directory is a character vector of length 1 indicating 
    ## the location of the CSV files
    
    ## id is an integer vector indicating the monitor ID numbers
    ## to be used.
    
    ## The function returns a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where id is the monitor ID number and nobs is 
    ## the number of complete cases
    
    ##Initialise data.frame for results
    ids <- c()
    nobs <- c()
    
    i <- 1
    l <- length(id)
    while (i <= l) { ## looping through the files
        ## format the filename
        filename <- paste0(directory,"/", formatC(id[i], width=3,flag="0"), ".csv") 
        
        ##  read "xxx.csv" file
        data <- read.csv(filename) 
        
        ## count 
        rowmax <- nrow(data)
        colmax <- ncol(data)
        count <- 0
        
        ## looping through rows
        for (j in 1:rowmax){ 
            if (any(is.na(data[j,]))==FALSE){ ## count rows only with no NA in any column
                count <- count + 1
            }
        }
        ids <- c(ids,id[i])
        nobs <- c(nobs,count)
        i <- i + 1
    }
    ## Add complete results
    data.frame(ids,nobs)
}