PlotDataVsModel	<-	function(bfd, S, eventID)  {

  browser()

  # Specifying colors
  dataCol			  <-	'green'
  modelCol		  <-	'black'
  tmrLeakageCol	<-	'red'
  trainingColor <-  '#FF000033'
  sh5AOnCol     <-  '#00FF0033'
  sh5AOffCol    <-  '#0000FF33'
  

  # Loading and filtering data
  leakage  	    <-	ReadTMRLeakage(eventID)
  trainingRanges<-  ExtractDataRanges(eventID=eventID, type=c('train'))
  sh5AOffRanges <-  ExtractDataRanges(eventID=eventID, type=c('Sh5AOff'))
  sh5AOnRanges  <-  ExtractDataRanges(eventID=eventID, type=c('Sh5AOn'))
  #myFilter     <-	with(bfd, ElapsedHours/24 >= trainingRanges$from[1] &
  #  ElapsedHours/24 <= trainingRanges$to[1])
  
  # Plotting
  with(bfd, plot(ElapsedHours/24, Flow, pch=19, cex=.4,col=dataCol,
                 xlab='Elapsed Days', ylab='Flow, mgd',
                 main=EventID2DateChar(eventID), xlim=c(0,1), 
                 ylim=c(-100,100)))
                 
  rect(xleft=trainingRanges$from, ybottom=rep(-1000, nrow(trainingRanges)),
       xright=trainingRanges$to, ytop=rep(1000, nrow(trainingRanges)), 
       col = trainingColor, border=trainingColor)

  if(nrow(sh5AOffRanges) > 0) {
    rect(xleft=sh5AOffRanges$from, ybottom=rep(-1000, nrow(sh5AOffRanges)),
         xright=sh5AOffRanges$to,  ytop=rep(1000, nrow(sh5AOffRanges)), 
         col = sh5AOffCol, border=sh5AOffCol)
  }
                 
  if(nrow(sh5AOnRanges) > 0) {
    rect(xleft=sh5AOnRanges$from, ybottom=rep(-1000, nrow(sh5AOnRanges)),
         xright=sh5AOnRanges$to, ytop=rep(1000, nrow(sh5AOnRanges)),
         col = sh5AOnCol, border=sh5AOnCol)
  }
  
  with(bfd, 
       lines(seq(0,1.5,.005), QModel(seq(0,1.5,.005), S),col=modelCol))

  lines(c(0,60), rep(leakage,2), col=tmrLeakageCol)
  
  # Legend
  txt		<-	c(	paste('Previously Reported Leakage: ', 	
                   round(leakage,1) ,sep=''), 
                paste('Model Estimate: ', round(S[[5]],1), sep=''),
                'Shaft 9 Flow (Accusonic)')
  types	<-	c(	'l', 'l', 'p')
  col		<-	c(tmrLeakageCol, modelCol, dataCol)
  bfLegend(text=txt, type=types, col=col)

  # Event-specific comments
  bfComments(eventID)
}
