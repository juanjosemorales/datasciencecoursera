corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        #--------------------------------------------------------
        #get all the files in the directory
        files  <- list.files(directory, full.names=TRUE)
        
        #get all the ids of files that meet the threshold
        all.files     <- complete(directory)
        app.threshold <- all.files[all.files$nobs > threshold, ]
        all.ids <- app.threshold$id
        #read the files that meet the threshold and store them in a data frame
        data <- data.frame()
        cors <- numeric()
        for (file in files[all.ids]) {
                data <- read.csv(file)
                #remove NAs
                good <- complete.cases(data)
                data <- data[good, ]
                #compute correlation for this monitor and attach it to the vector of correlations
                cors <- rbind(cors, cor(data$nitrate, data$sulfate))
        }
        cors
}