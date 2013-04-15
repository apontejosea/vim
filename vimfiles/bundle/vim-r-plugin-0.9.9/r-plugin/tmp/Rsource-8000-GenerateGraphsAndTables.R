library(plyr)
tcd$Year <- as.numeric(as.character(years(tcd$Dates)))
classifiers <- c('Lines','LineCombination','Year')
fields <- c('Delta','RECDev','Sh9Dev')
myFilter <- with(tcd, Outliers==FALSE & Lines != -999 & Dates >=
                 as.chron('2007-01-01') & LineCombination != '')
sData <- Stack(tcd[myFilter,], select=fields, carryover = c(classifiers))
tbl <- aggregate(x=sData[,'values'], by=as.list(sData[,c('ind',classifiers)]),
                 FUN=function(X) round(mean(X, na.rm=TRUE), 2))
