Transform_H2D <- function(df, min.hours=18)  {
  library(chron)
  library(plyr)

  # First column should be of class 'dates' and its name should be DateTime (by
  # convention)
  stopifnot(names(df)[1]=='DateTime' & 'dates' %in% c(class(df[,1])))
  # All columns to be averaged out should be numeric.
  stopifnot(all(DFClasses(df[,-1, drop=F])=='numeric'))

  df$Dates     <- as.Date(df$DateTime)
  res          <- ddply(df[,names(df)[-1]], .(Dates), colwise(mean), na.rm=TRUE)
  res$Dates    <- as.chron(res$Dates)

  nRows        <- ddply(df, .(Dates), nrow)

  # Only include in results days for which there is more than min.hours hours in
  # the hourly data set
  ind <- which(nRows[,2] < min.hours)
  if(length(ind)>0)  res <- res[-ind,]

  return(res)
}
