Graph_BackflowResults	<-	function(
  IDList= with(ReadBFParameters(),
              EventID[ValidEvent==T]),
  data  = get('BFData', envir=globalenv()),
  params= get('bfParams', envir=globalenv()))  {

  #	Filtered events to uncomment for debuging purposes
  #	IDList	<-	c('20071120', '20100113')
  #	IDList	<-	c('20071120','20081025','20100603')
  #	IDList	<-	c('20030116','20060329','20060525','20071120','20071204',
  # '20071211', '20080529','20090402')
  par(mfrow=c(5,3))
  cat(c('Processing...\n'))
  for(i in 1:length(IDList))  {
    # This prints the current eventID to the screen, to let the user know 
  	# which event is currently being processed.
  	cat(paste(IDList[[i]],'\n',sep=''))
  	singleBFData	<-	ExtractSingleEvent(eventID=IDList[[i]], data=data)
  
    # TODO: This reads the initial guess for the model parameters and prints it 
  	# to the screen. This could be a conditional for missing parameter 
  	# values in BFTParameters.xlsx. If the first guess of model parameters
  	# is missing, this would not plot the model output.
    ind   <-  which(params$EventID==IDList[[i]])
  	S 		<-	params[ind, c('alpha','beta','chi','delta','epsilon')]
    
  	# Selects the next position in the page layout and plots the data vs 
  	# model with optimal parameters
  	dev.next()
#    PlotDataVsModel(singleBFData, S, eventID=IDList[[i]])
    PlotLeakageEstimate(eventID=IDList[[i]], data = data, params = params)
  }
}
