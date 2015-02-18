plot1 <- function() {
        
        #Read in the data with headers and separator as ;
        d <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
        #convert the date into an R date object
        d$Date <- as.Date(d$Date, format="%d/%m/%Y")
        
        #select only the dates we want 
        d <- d[which(d$Date %in% as.Date(c('2007-02-01', '2007-02-02'))), ]
        
        #convert the levels into numeric
        d$Global_active_power <- as.numeric(levels(d$Global_active_power)[d$Global_active_power])
        
        png("plot1.png", width=480, height=480)
        hist(d$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col=c("red"))
        dev.off()
}