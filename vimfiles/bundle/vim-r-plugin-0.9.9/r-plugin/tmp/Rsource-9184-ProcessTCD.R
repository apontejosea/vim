ProcessTCD	<-	function(
    data.dir='data/DailyData', 
    output.dir='lib/src/packages/DailyData/data',
    calcOG=T)  {
  print('Reading data...')
  tcd                     <-  ReadTCD(file.path(data.dir, 'tcd.csv'))
  hglData                 <-  ReadHGL(file.path(data.dir, 'hgld.csv'))
  sgModes                 <-  ReadModesChanges(file.path(data.dir, 'SluiceGateModeChanges.csv'))

  print('Attaching HGL data')
  # tcd                     <-  MergeHGL(tcd, hglData)
  
	print('Calculating Year...')
	tcd$Year			          <-	years(tcd$Dates)
	
	print('Calculating YearQtr...')
	tcd$YearQtr		          <-	with(tcd, as.YearQtr(Dates))
	
	print('Updating LinesOpen...')
	tcd$Lines	              <-	with(tcd, UpdateLinesOpen(Lines, RECQ))

	print('Calculating Prediction...')
	tcd$Prediction		      <-	with(tcd, CalculateFlowPrediction(Rondout, WestBranch, Lines))
	
	print('Calculating RECDev...')
	tcd$RECDev			        <-	with(tcd, RECQ-Prediction)

	print('Calculating Sh9Dev...')
	tcd$Sh9Dev			        <-	with(tcd, Sh9Q-Prediction)

	print('Calculating RECPDev...')
	tcd$RECPDev			        <-	with(tcd, RECDev/Prediction*100)
	
	print('Calculating Sh9PDev...')
	tcd$Sh9PDev			        <-	with(tcd, Sh9Dev/Prediction*100)

	print('Calculating Delta...')
	tcd$Delta	              <-	with(tcd, RECQ - Sh9Q)

	print('Calculating RECPDelta')
	tcd$RECPDelta			      <-	with(tcd, Delta/RECQ*100)

	print('Calculating Sh9PDelta')
	tcd$Sh9PDelta			      <-	with(tcd, Delta/Sh9Q*100)
	
	print('Calculating DrivingHead...')
	tcd$DrivingHead		      <-	with(tcd, Rondout-WestBranch)

	if(calcOG==TRUE){
		print('Calculating OperationGroups...')
    result                <-  with(tcd, CalculateOperationGroups(Dates, Lines))
		tcd$OperationGroups	  <-  result$from
    tcd$OperationGroups2  <-  result$to
  }
	
	
	print('Calculating LineCombination...')
	tcd$LineCombination 	  <-	
    CalculateLinesCombination(tcd[,c('E1','W1','E2','W2','E3','W3')])
	
  print('Generating Sluice Gates Modes...')
  tcd$Modes               <-  GetModesData(tcd$Dates, modes=sgModes)
  
  print('Calculating DeltaHGL...')
  tcd$DeltaHGL            <-  with(tcd, Sh1HGL - Sh9HGL)
  
  print('Calculating fREC...')
  tcd$fREC                <-  with(tcd, CalculateF(RECQ, Sh1HGL, Sh9HGL))
  
  print('Calculating fSh9...')
  tcd$fSh9                <-  with(tcd, CalculateF(Sh9Q, Sh1HGL, Sh9HGL))

  attr(tcd, 'labels')     <-  GetDataLabels(names(tcd))
  
	tcd	                    <-	tcd[, c(
                                    "Dates", 
                                    "Outliers", "Lines", "LineCombination", "Modes", "YearQtr", 
                                    "OperationGroups", "OperationGroups2", 
                                    "RECQ", "Sh9Q", "Sh5AQ", "Delta",
                          					"Rondout", "WestBranch", "DrivingHead",
                          					"Prediction", "RECDev", "RECPDev", "Sh9Dev", "Sh9PDev", "RECPDelta", "Sh9PDelta", 
                                    "E1", "W1", "E2", "W2", "E3", "W3", 
                                    "Sh1HGL", "Sh2AHGL", "Sh5AHGL", "Sh6HGL", "Sh8HGL", "Sh9HGL", "DeltaHGL",
                                    "fREC", "fSh9"
                                    )]
  
  attr(tcd, 'labels')    <-  GetDataLabels(names(tcd))
  
  save(tcd,            file=file.path(output.dir, 'tcd.rda'))
  save(sgModes,        file=file.path(output.dir, 'sgModes.rda'))
}
