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



SCC_coal_comb <- SCC[grepl("comb", SCC$EI.Sector, ignore.case=TRUE) &
+                        grepl("coal", SCC$EI.Sector, ignore.case=TRUE),]
#head(SCC_coal_comb)
#unique(SCC_coal_comb[[1]])
coal_comb = unique(SCC_coal_comb[[1]])
cc = which(NEI$SCC %in% coal_comb)
#head(cc)
Coal_Comb_Data = NEI[cc,]
#head(Coal_Comb_Data)
coal_agg = aggregate(Coal_Comb_Data$Emission~Coal_Comb_Data$year,data=Coal_Comb_Data,FUN=sum)
coal_agg[[2]] = coal_agg[[2]]/1000

barplot(coal_agg[[2]],names.arg=coal_agg[[1]],main="PM2.5 emission from coal-combustion related sources",ylab="PM2.5 Emissions in kilo tons",xlab="Years",col = c("red","green","blue","gray"))
dev.copy(png,'plot4.png')
dev.off()
graphics.off()
