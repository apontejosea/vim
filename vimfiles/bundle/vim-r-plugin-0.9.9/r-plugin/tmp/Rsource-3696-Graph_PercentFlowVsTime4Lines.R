Graph_PercentFlowVsTime4Lines	<-	function(from, to, data=tcd2) {

  library(lattice)


  options(nsmall=2)
  DPM				    <-	matrix(
      nrow=5,ncol=6, 
      byrow=TRUE, 
      dimnames=list(
          n=c(1:4, 6), 
          i=c('E1','W1','E2','W2','E3','W3')))
	
	# For 1 to 4-Lines Open
	# Expected delivery percentage on each of the possibly open lines is 1/n
	# where n is the number of open lines at the moment
	for(n in 1:4) {
		DPM[n,1:4]	<-	1/n
	}
	
	# For 6-Lines open
	# Expected delivery percentage on the large lines (l) and the smaller lines (s)
	# myFilter	<-	with(tcd, Lines %in% c(6) & !is.na(E3) & !is.na(W3))
	# myFilter	<-	with(tcd, Lines %in% c(6) & E1 > 70 & format(Dates, '%Y') >= 2008)
	myFilter      <-	with(data, Lines %in% c(4) & format(Dates, '%Y') >= 2008 & Outliers==FALSE)
	Q42			      <-	with(data[myFilter,], mean(E1+W1+E2+W2))
	s			        <-	0.25*100
	
	# Finalizing the Expected Delivery Percentage Matrix P
	DPM[5,1:4]	  <-	mean(s)
	
	# Now we should be able to calculate time-wise percentage of 
	# delivery and compare with the expected percentage.
	# In order to calculate the flow percent delivery
	# P = [E1,..., W3]/QREC
	# After that I should be able to graph it.
	lineNames			<-	c('E1','W1','E2','W2','E3','W3')
	percentFlow		<-	data[myFilter, lineNames]/data$RECQ[myFilter]
	Pbar		      <-	colMeans(percentFlow, na.rm=TRUE)
	
	x			        <-	data$Dates[myFilter]
	y1			      <-	percentFlow[,'E1']*100
	y2			      <-	percentFlow[,'W1']*100
	y3			      <-	percentFlow[,'E2']*100
	y4			      <-	percentFlow[,'W2']*100

  yRangeS         <-  round(extendrange(c(y1,y2,y3,y4), f=.3), 0)
  
  myAtYS=pretty(yRangeS)
  
#	yRangeS	      <-	c(24, 26)
#	
#	myAtYS        <-   seq(yRangeS[1], yRangeS[2], 1)
	
	grid.newpage()
	pushViewport(plotViewport())
	pushViewport(viewport(layout=grid.layout(nrow=4)))
	
	# Main external parameters
	myTitle		    <-	'Figure D.8\nPercent Flow Delivery on each line for the 4-Lines open condition'
	titleStyle	  <-	gpar(fontface='bold')
	grid.text(myTitle, y=unit(1, 'npc')-unit(-2, 'lines'), gp=titleStyle)
	

	pushViewport(dataViewport(xData=as.numeric(x),yData=yRangeS, layout.pos.row=1,extension = c(.05,.1)))
	grobMeanDevVsTime(dates=x,signal=y1,drawXAxis=FALSE, target=s, plab='E1', myAtY=myAtYS)
	
	upViewport()
	pushViewport(dataViewport(xData=as.numeric(x),yData=yRangeS, layout.pos.row=2,extension = c(.05,.1)))
	grobMeanDevVsTime(dates=x,signal=y2,drawXAxis=FALSE, target=s, plab='W1', myAtY=myAtYS)
	upViewport()
	pushViewport(dataViewport(xData=as.numeric(x),yData=yRangeS, layout.pos.row=3,extension = c(.05,.1)))
	grobMeanDevVsTime(dates=x,signal=y3,drawXAxis=FALSE, target=s, plab='E2', myAtY=myAtYS)
	upViewport()
	pushViewport(dataViewport(xData=as.numeric(x),yData=yRangeS, layout.pos.row=4,extension = c(.05,.1)))
	grobMeanDevVsTime(dates=x,signal=y4,target=s, plab='W2', myAtY=myAtYS)
	
	pushViewport(viewport(x=1,y=0,height=unit(2, 'lines'), width=unit(30, 'lines'), just=c('right','bottom')))
	GridLegendTargetDeviation(pointLabel='Percent Flow', lineLabel='Expected Perc. Flow')
	
	upViewport(3)
	grid.text("Percent Delivery, %", x=unit(-3.5, 'lines'), rot=90, gp=gpar())
}
