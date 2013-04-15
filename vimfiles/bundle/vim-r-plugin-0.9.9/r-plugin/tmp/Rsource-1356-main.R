library(TimeUtils)
library(Utility)
library(chron)
library(lattice)

bnaData <- read.csv('data\\BNAData.csv')
bnaData$DateTime<-TimeUtils::xlDateTime2Chron(bnaData$DateTime)
bnaData$Stage <- factor(bnaData$Stage, levels=c('BEFORE', 'AFTER', 'DURING'))
myFilter <- with(bnaData, Outliers==FALSE)

sData <- Stack(bnaData[myFilter,], select=names(bnaData)[-c(1:3, (ncol(bnaData)-0:2))], carryover=c('DateTime', 'RECQ', 'Sh9Q', 'Outliers', 'Stage','Lines'))

p1 <- xyplot(values~DateTime|ind, group=Stage, data=sData, as.table=T, layout=c(5,1), xlab='', auto.key=TRUE)
p2 <- xyplot(values~RECQ|ind, group=Stage, data=sData, as.table=T, layout=c(5,1), xlab='')
p3 <- xyplot(values~Sh9Q|ind, group=Stage, data=sData, as.table=T, layout=c(5,1), xlab='')
