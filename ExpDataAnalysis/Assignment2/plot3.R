plot3 <- function()  {
        
        library(dplyr)
        
        #read in the data
        a <- readRDS("summarySCC_PM25.rds")
        b <- readRDS("Source_Classification_Code.rds")
        
        #get the emissions and year for baltimore, fips=24510
        baltimore = subset(a, fips == "24510", select=c(year, Emissions, type))
        
        #pre aggregate the emissions per year, group by type and year
        agg <- baltimore %>% group_by(year, type) %>% summarise_each(funs(sum))
        
        #make plote and save it as png
        png("plot3.png", width=480, height=480)
        print(qplot(year, Emissions, data=agg, group=type, color=type, geom=c("point", "line"), xlab="Year", ylab="Emmissions in Tons", main="Total Emissions in Baltimore by Type"))
        dev.off()
        
}