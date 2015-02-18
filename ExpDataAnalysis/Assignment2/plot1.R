plot1 <- function() {

        #read in the data
        a <- readRDS("summarySCC_PM25.rds")
        b <- readRDS("Source_Classification_Code.rds")
        
        #pre aggregate the emissions per year
        p1 <- aggregate(a$Emissions, by=list(a$year), FUN=sum)
        names(p1) = c("year", "emissions")
        
        #make a plot to answer question 1 and save it as png
        png("plot1.png", width=480, height=480)
        plot(p1$year, p1$emissions,  type="l", main="Emmisions per Year", xlab="Year", ylab="Emissions (Tons)")
        dev.off()

}