GetTSDataFrame <- function(filepath=choose.files(),firstDataColumn=2,lastDataColumn=2) {
  library(chron)
  
  ## filepath is where the timeseries is located
  ## openning and reading the data from the file
  TSRaw <- read.csv(filepath, sep=",", header=T, as.is = TRUE)
  
  ## strsplit wraps up the output in a strange structural format 
  ## on a list object.  The method unlist cleans up the output into a vector.
  colNo <- 1  ## it is assumed that the date, time is provided on the first column. Change this value with the column number where datetime is if necessary.
  DTRaw <- unlist(strsplit(TSRaw[,colNo], " "))
  
  ## The output of the previous command comes in the form of a 
  ## 1-dimensional vector where the dates are stored in the odd-numbered 
  ## indices while the times are stored in the even-numbered indices.
  ## The following code separates Dates and Times into their own vectors.
  Dates = DTRaw[seq(1, length(DTRaw),2)]
  Times = DTRaw[seq(2, length(DTRaw),2)]
  
  ## Don't need to use this command if the csv file already had seconds in it.
  ## This changes the format of the time to make it compatible with chron time format "h:m:s" (should include seconds).
  Times = paste(Times, ":00", sep = "")
  
  ## Defining first and last data column numbers.  Assuming data is in consecutive columns.
  fDataCol <- firstDataColumn
  lDataCol <- lastDataColumn
  
  ## DataValues is a vector with the data corresponding to the above defined dates and times.
  DataValues = TSRaw[,fDataCol:lDataCol]
  
  ## This code creates an object of type chron.
  DateTime <- chron(Dates, Times)
  
  return(data.frame(DateTime, DataValues))
}
