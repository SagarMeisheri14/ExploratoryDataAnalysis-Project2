NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#str(NEI)
#unique(NEI$type)
#unique(NEI$year)
typ = unique(NEI$type)
yrs = unique(NEI$year)
NEI$year = factor(NEI$year,levels=yrs)
NEI$type = factor(NEI$type,levels=typ)
#str(NEI)
scc = unique(NEI$SCC)
#head(scc)
NEI$SCC = factor(NEI$SCC,levels=scc)
#length(scc)
fp = unique(NEI$fips)
#length(fp)
NEI$fips = factor(NEI$fips,levels=fp)
#str(NEI)


bc = which(NEI$fips=="24510")
baltimore = NEI[bc,]
#str(baltimore)
#str(baltimore$fips)
#head(baltimore$fips)
baltimore_agg = aggregate(Emissions~year,data=baltimore,FUN=sum)
baltimore_agg[[2]] = baltimore_agg[[2]]/1000


barplot(baltimore_agg[[2]],names.arg=baltimore_agg[[1]],main="total PM2.5 emission (year-wise)",ylab="PM2.5 Emissions in kilo tons",xlab="Years",col = c("red","green","blue","gray"))
dev.copy(png,'plot2.png')
dev.off()
graphics.off()
