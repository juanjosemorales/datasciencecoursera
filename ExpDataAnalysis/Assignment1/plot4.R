plot4 <- function() {
        
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
        d$Voltage <- as.numeric(levels(d$Voltage)[d$Voltage])
        d$Global_reactive_power <- as.numeric(levels(d$Global_reactive_power)[d$Global_reactive_power])
        d$Sub_metering_1 <- as.numeric(levels(d$Sub_metering_1)[d$Sub_metering_1])
        d$Sub_metering_2 <- as.numeric(levels(d$Sub_metering_2)[d$Sub_metering_2])
        
        #for the legend
        met <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        
        png("plot4.png", width=480, height=480)
        par(mfrow=c(2,2))
        plot(d$t, d$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        plot(d$t, d$Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(d$t, d$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(d$t, d$Sub_metering_2, col="red")
        lines(d$t, d$Sub_metering_3, col="blue")
        legend("topright", met, lty=c(1,1,1), col=c("black", "red", "blue"))
        plot(d$t, d$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        dev.off()

}