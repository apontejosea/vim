strFrom                 <- strftime(min(sh9DailyData$Dates),"%Y%m%d")
strTo                   <- strftime(max(sh9DailyData$Dates),"%Y%m%d")
filePreamble            <- paste(strFrom, '-', strTo, sep='')
