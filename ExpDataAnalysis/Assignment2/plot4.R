plot4 <- function()  {
        
        library(dplyr)
        
        #read in the data
        a <- readRDS("summarySCC_PM25.rds")
        b <- readRDS("Source_Classification_Code.rds")
        
        #subset only the sectors that have the word Coal to get emissions from coal combustion-related sources 
        coal = subset(b, grepl(".*Coal.*", b$EI.Sector))
        
        #merge the two datasets to get only the coal emissions, both have SCC as common name
        coalEms = merge(coal, a)
        
        p1 <- aggregate(coalEms$Emissions, by=list(coalEms$year), FUN=sum)
        names(p1) = c("year", "emissions")
        
        #make plot and save it as png
        png("plot4.png", width=480, height=480)
        
        #use ggplot to answer the question, the smooth should be enough to see that it decreases
        print(qplot(year, emissions, data=p1, geom=c("point", "line"), method="lm", main="Coal Emissions Accross USA"))
        dev.off()
        
}