complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        files  <- list.files(directory, full.names=TRUE)
        col.id <- id
        nobs   <- numeric(length(id))
        i <- 1
        for (file in files[id]) {
                good    <- complete.cases(read.csv(file)) 
                nobs[i] <- sum(good)
                i <- i + 1
        }
        complete.data <- data.frame(col.id, nobs)
        names(complete.data) <- c("id", "nobs")
        complete.data
}