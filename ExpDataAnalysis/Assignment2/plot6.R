plot6 <- function() {
        
        library(dplyr)
        
        #read in the data
        a <- readRDS("summarySCC_PM25.rds")
        b <- readRDS("Source_Classification_Code.rds")
        
        #get the emissions only for baltimore, fips=24510 and LA, fips=06037
        baltimore.and.LA = subset(a, fips == "24510" | fips == "06037")
        
        #subset only the sectors that have the word Coal to get emissions from motor vehicles sources 
        mobile = subset(b, grepl(".*Mobile.*", b$EI.Sector)) 
        
        #merge the two datasets to get only the mobile emissions for baltimore and LA, both have SCC as common name
        mobile.ems = merge(mobile, baltimore.and.LA)
        
        #intermediate data frame to hold only what we need to do the aggregation
        mobile.ems = data.frame(mobile.ems$fips, mobile.ems$Emissions, mobile.ems$year)
        names(mobile.ems) = c("county", "emissions", "year")
        
        #pre aggregate the emissions per year, group by year and county
        agg <- mobile.ems %>% group_by(year, county) %>% summarise_each(funs(sum))
        
        #change the names of fips to the names of the actual counties
        agg$county <- as.character(agg$county)
        agg$county[which(agg$county=="06037")] = "LA"
        agg$county[which(agg$county=="24510")] = "Baltimore"
        agg$county <- factor(agg$county)
        
        #make and pring the plot
        png("plot6.png", width=480, height=480)
        print(qplot(year, emissions, data=agg, group=county, color=county, geom=c("point", "line"), xlab="Year", ylab="Emmissions in Tons", main="Yearly Mobile Emissions in Baltimore and LA"))
        dev.off()
}