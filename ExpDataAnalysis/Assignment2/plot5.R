plot5 <- function() {
        
        #read in the data
        a <- readRDS("summarySCC_PM25.rds")
        b <- readRDS("Source_Classification_Code.rds")
        
        #subset only the sectors that have the word Coal to get emissions from motor vehicles sources 
        mobile = subset(b, grepl(".*Mobile.*", b$EI.Sector))        
        
        #get the emissions only for baltimore, fips=24510
        baltimore = subset(a, fips == "24510")
        
        #merge the two datasets to get only the mobile emissions for baltimore, both have SCC as common name
        mobileEms = merge(mobile, baltimore)
        
        p1 <- aggregate(mobileEms$Emissions, by=list(mobileEms$year), FUN=sum)
        names(p1) = c("year", "emissions")
        
        #make plot and save it as png
        png("plot5.png", width=480, height=480)
        print(qplot(year, emissions, data=p1, geom=c("point", "line"), method="lm", main="Motor Vehicle Emissions From Baltimore City"))
        dev.off()
}