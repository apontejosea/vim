RoundHour  <- function(x)  {
  res <-  trunc(x,'hours', eps=1e-17)
  res <-  ifelse((x-res) > 0.5/24, res+1/24, res)
  return(as.chron(res))
}
