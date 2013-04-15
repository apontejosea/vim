library(TimeUtils)
library(Utility)
library(chron)
library(lattice)

bnaData <- read.csv('data\\BNAData.csv')
bnaData$DateTime<-TimeUtils::xlDateTime2Chron(bnaData$DateTime)
