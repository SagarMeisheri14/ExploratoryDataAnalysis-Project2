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
baltimore_agg2 = aggregate(Emissions~year+type,data=baltimore,FUN=sum)
baltimore_agg2[[2]] = baltimore_agg2[[2]]/1000


ggplot(baltimore_agg2,aes(year,Emissions,fill=type))+geom_bar(stat="identity")+facet_wrap(~type)
dev.copy(png,'plot3.png')
dev.off()
graphics.off()
