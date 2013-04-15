RunNLMFit	<-	function(eventID='20100113', S0=ExtractS(eventID), 
                      bfd=get("BFData", envir=globalenv()), stepmax=10,
                      dataRanges=dataRanges)  {
	dataRanges		<-	ExtractDataRanges(data=dataRanges, eventID=eventID, type=c('train'))
	singleBFData	<-	bfd[bfd$EventID==eventID,c('ElapsedHours','Flow')]

	myFilter		<-	with(singleBFData, ElapsedHours/24 >= dataRanges$from[1] & ElapsedHours/24 <= dataRanges$to[1])
	result			<-	nlm(Objective, as.numeric(S0), bfd=singleBFData[myFilter,], stepmax=stepmax)

  return(result)
}
