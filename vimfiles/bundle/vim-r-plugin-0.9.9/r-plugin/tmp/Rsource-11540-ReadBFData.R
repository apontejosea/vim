#' @title Reads all backflow data
#' 
#' Reads all the available backflow data in directory defined by data.path
#' 
#' @param data.dir    folder with backflow data files
#' @param minHours    minimum number of hours the data needs to have to be included in the query result. Defaults to 0.
#' @param maxHours    maximum number of hours the data needs to have to be included in the query result. Defaults to 30.
#' @param verbose     logical.  Should verbose be printed?, defaults to FALSE
#' @return            main backflow data.frame
#' @author Jose Aponte \email{jose.aponte@@arcadis-us.com}
#' @import stringr
#' @export
ReadBFData <-  function (data.dir = "data/Backflow/csv",
    minHours = 0, maxHours = 30,
    verbose = FALSE)  {
  
  library(stringr)
  
  myFiles       <- dir(path=data.dir, pattern = glob2rx("*Backflow.csv"), full.names=T)
  pattern       <-  '(\\d{8}\\w{0,1})\\s-\\sBackflow.csv'
  extraction    <-  str_match_all(paste(myFiles, collapse=' '), pattern)
  eventID       <- extraction[[1]][,2]
  allData       <- data.frame()

  for (i in 1:length(myFiles)) {
    if (verbose == TRUE)
      print(paste("EventID = ", eventID[i], sep = ""))
    myBFData              <-  read.csv(myFiles[i], as.is=TRUE)
    myBFData$Flow         <-  as.numeric(myBFData$Flow)
    myBFData$DateTime     <-  xlDateTime2Chron(myBFData$DateTime)
    
    ind                   <-  which(abs(myBFData[, 2]) < 150)
    myBFData              <-  myBFData[ind, ]
    myBFData$ElapsedDays  <-  as.numeric(myBFData[, 1] - myBFData[1, 1])
    myBFData$ElapsedHours <-  myBFData$ElapsedDays*24
    allData               <-  rbind(allData, 
                                    data.frame( myBFData, 
                                                EventID = rep(eventID[i], nrow(myBFData))))
  }
  
  ind                     <- with(allData, which(
                                      ElapsedHours < maxHours & 
                                      ElapsedHours > minHours))
  allData         <- allData[ind, ]
  allData$EventID <- as.factor(as.character(allData$EventID))
  return(allData)
}
