expandblank <- function(x, width)  {
  tempRes <- character(length(x))
  for(i in 1:length(x))  {
    tempRes[i] <- paste(rep(' ', width-nchar(x[i])-1), collapse='')
  }
  paste(x, tempRes)
}
