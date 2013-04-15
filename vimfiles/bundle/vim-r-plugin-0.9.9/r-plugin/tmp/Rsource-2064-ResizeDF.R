ResizeDF  <-  function(df, 
                       from=dates(as.chron(min(df[,1]))), 
                       to=as.chron(Sys.Date()))  {

  library(TimeUtils)

  if(!names(df)[1] %in% c('Dates','DateTime'))
    stop('First column of df should be named either Dates or DateTime')


  if(names(df)[1]=='Dates')
    freq  <- 'daily'
  else if(names(df)[1]=='DateTime')
    freq  <- 'hourly'

  tempDF <- data.frame(DateTime=CreateChronVector(from, to,
                                                  frequency=freq))

  names(tempDF)[1]    <-  names(df)[1]
  tempDF[,1]          <- RoundHour(tempDF[,1])
  df[,1]              <- RoundHour(df[,1])
  res                 <- merge(tempDF, df, all=T)
  return(res)
}
