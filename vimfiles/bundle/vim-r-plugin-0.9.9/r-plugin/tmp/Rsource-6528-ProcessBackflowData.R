ProcessBackflowData <-  function( 
    data.dir      = 'data/BFTData', 
    output.dir    = 'lib/src/packages/Backflow/data')  {
  
  
  library(Backflow)

  bfParams  <-  ReadBFParameters(file = file.path(data.dir, 'BFTParameters.csv'))
  BFData    <-  ReadBFData(data.dir = data.dir)
  
  # Only consider valid events
  ind       <-  which(bfParams$ValidEvent==TRUE)
  IDList    <-  bfParams$EventID[ind]
  #  bfParams  <-  bfParams[ind,]
  
  # No need to have S defined for events with no raw backflow data available
  ind           <-  with(bfParams, BFDataAvailable == FALSE)
  bfParams[ind, c('alpha', 'beta', 'chi', 'delta', 'epsilon')] <-  NA
  browser()  
  cat(c('Processing...\n'))
  for(i in 1:length(IDList))  {
    # This prints the current eventID to the screen, to let the user know 
    # which event is currently being processed.
    cat(paste(IDList[[i]],'\n',sep=''))
    
    singleBFData  <-  ExtractSingleEvent(IDList[[i]], data = BFData)
    S0            <-  ExtractS(IDList[[i]])
    
    cat(paste('Initial S: ', paste(round(S0,1) , collapse=','),'\n',sep=''))
    
    # This fits the model to the data and returns the optimal parameter 
    # values and prints them to the screen.
    SOpt          <-  RunNLMFit(eventID=IDList[[i]], S0=S0, data=BFData, stepmax=10, dataRanges=dataRanges)$estimate
    cat(paste('Optimal S: ', paste(round(SOpt,1), collapse=','),'\n',sep=''))

    ind <-  which(bfParams$EventID == IDList[[i]])
    bfParams[ind, c('alpha', 'beta', 'chi', 'delta', 'epsilon')]  <-  SOpt
    bfParams[ind, 'Sh5ADailyAvg']   <-  GetDataByDates(EventID2ChronChar(IDList[[i]]), fields='Sh5AQ')[[1]]
  }

  save(BFData,    file  = file.path(output.dir, 'BFData.rda'))
  save(bfParams,  file  = file.path(output.dir, 'bfParams.rda'))
}
