CollectSh9QData  <-  function(file=choose.files())  {

  library(TimeUtils)
  library(zoo)

  browser()
  stopifnot(file != "")
  rawSh9Data  		        <-  read.csv(file, header = FALSE)
  rawSh9Data              <-  rawSh9Data[,1:2]
  names(rawSh9Data)       <-  c('DateTime.Sh9', 'Sh9Q')
  rawSh9Data$DateTime.Sh9 <-  xlDateTime2Chron(as.character(rawSh9Data$DateTime.Sh9))
  rawSh9Data$DateTime     <-  TimeUtils::RoundHour(rawSh9Data$DateTime.Sh9)

  zooSh9Data              <-  zoo(rawSh9Data, order.by=rawSh9Data$DateTime)
  zooSh9Data$DateTime     <-  as.chron(zooSh9Data$DateTime)
  zooSh9Data$DateTime.Sh9 <-  as.chron(zooSh9Data$DateTime.Sh9)
  zooSh9Data$DateTime     <-  as.chron(zooSh9Data$DateTime)

  from <- dates(min(rawSh9Data$DateTime))
  to   <- dates(max(rawSh9Data$DateTime))
  dtVector <- TimeUtils::RoundHour(CreateChronVector(from, to))
  dtVector <- zoo(dtVector, order.by=dtVector)
  myData <- merge(x=data.frame(DateTime=dtVector), y=rawSh9Data, all.x=TRUE, all.y=TRUE)
  # merge(x, y, by = intersect(names(x), names(y)),
  #       by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
  #       sort = TRUE, suffixes = c(".x",".y"),
  #       incomparables = NULL, ...)

  return(myData)
}
