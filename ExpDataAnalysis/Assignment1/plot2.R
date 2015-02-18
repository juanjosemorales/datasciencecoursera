plot2 <- function() {
        
        #Read in the data with headers and separator as ;
        d <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
        #convert the date into an R date object
        d$Date <- as.Date(d$Date, format="%d/%m/%Y")
        
        #Merge the Date and Time into one column and bind it to the rest of the data
        t <- as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")
        d <- cbind(t, d)
        
        #select only the dates we want 
        d <- d[which(d$Date %in% as.Date(c('2007-02-01', '2007-02-02'))), ]
        
        #convert the levels into numeric
        d$Global_active_power <- as.numeric(levels(d$Global_active_power)[d$Global_active_power])
        
        png("plot2.png", width=480, height=480)
        plot(d$t, d$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.off()
}