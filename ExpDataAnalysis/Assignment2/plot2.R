plot2 <- function()  {
        
        #read in the data
        a <- readRDS("summarySCC_PM25.rds")
        b <- readRDS("Source_Classification_Code.rds")
        
        #get the emissions and year for baltimore, fips=24510
        baltimore = subset(a, fips == "24510", select=c(Emissions, year))
        
        #aggregate the data
        p1 <- aggregate(baltimore$Emissions, by=list(baltimore$year), FUN=sum)
        names(p1) = c("year", "emissions")
        
        
        #make plote and save it as png
        png("plot2.png", width=480, height=480)
        plot(p1$year, p1$emissions,  type="l", main="Emmisions per Year in Baltimore City", xlab="Year", ylab="Emissions (Tons)")
        dev.off()
        
}