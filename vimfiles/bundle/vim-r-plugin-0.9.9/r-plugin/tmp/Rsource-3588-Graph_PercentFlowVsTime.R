Graph_PercentFlowVsTime6Lines	<-	function(tcd) {

  browser()

  options(nsmall=2)
  DPM				<-	matrix(nrow=5,ncol=6, byrow=TRUE, dimnames=list(n=c(1:4, 6), i=c('E1','W1','E2','W2','E3','W3')))

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
  myFilter	<-	with(tcd, Lines %in% c(6) & format(Dates, '%Y') >= 2008)
  Q54			<-	with(tcd[myFilter,], mean(E3+W3))
  Q42			<-	with(tcd[myFilter,], mean(E1+W1+E2+W2))
  s			<-	Q42/4/(Q54+Q42)*100
  l			<-	Q54/2/(Q54+Q42)*100

  # Finalizing the Expected Delivery Percentage Matrix P
  DPM[5,1:4]	<-	mean(s)
  DPM[5,5:6]	<-	mean(l)

  # Now we should be able to calculate time-wise percentage of 
  # delivery and compare with the expected percentage.
  # In order to calculate the flow percent delivery
  # P = [E1,..., W3]/QREC
  # After that I should be able to graph it.
  lineNames			<-	c('E1','W1','E2','W2','E3','W3')
  P			<-	tcd[myFilter, lineNames]/tcd$RECQ[myFilter]
  Pbar		<-	colMeans(P, na.rm=TRUE)

  x			<-	tcd$Dates[myFilter]
  y1			<-	P[,'E1']*100
  y2			<-	P[,'W1']*100
  y3			<-	P[,'E2']*100
  y4			<-	P[,'W2']*100
  y5			<-	P[,'E3']*100
  y6			<-	P[,'W3']*100

  yRangeL	<-	c(30,40)
  yRangeS	<-	c(5,15)

  myAtYS=seq(yRangeS[1],yRangeS[2], 2)
  myAtYL=seq(yRangeL[1],yRangeL[2], 2)

  grid.newpage()
  pushViewport(plotViewport())
  pushViewport(viewport(layout=grid.layout(nrow=6)))

  # Main external parameters
  myTitle		<-	'Figure D.9\nPercent Flow Delivery on each line for the 6-Lines open condition'
  titleStyle	<-	gpar(fontface='bold')
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
  grobMeanDevVsTime(dates=x,signal=y4,drawXAxis=FALSE, target=s, plab='W2', myAtY=myAtYS)
  upViewport()
  pushViewport(dataViewport(xData=as.numeric(x),yData=yRangeL, layout.pos.row=5,extension = c(.05,.1)))
  grobMeanDevVsTime(dates=x,signal=y5,drawXAxis=FALSE, target=l, plab='E3', myAtY=myAtYL)
  upViewport()
  pushViewport(dataViewport(xData=as.numeric(x),yData=yRangeL, layout.pos.row=6,extension = c(.05,.1)))
  grobMeanDevVsTime(dates=x,signal=y6, target=l, plab='W3', myAtY=myAtYL)

  pushViewport(viewport(x=1,y=0,height=unit(2, 'lines'), width=unit(30, 'lines'), just=c('right','bottom')))
  GridLegendTargetDeviation(pointLabel='Percent Flow', lineLabel='Expected Perc. Flow')

  upViewport(3)
  grid.text("Percent Delivery, %", x=unit(-3.5, 'lines'), rot=90, gp=gpar())

  grid.rect(x=0,y=0,height=unit(2,'lines'),width=unit(30,'lines'),just=c('left','bottom'),gp=gpar(fill='white'))
  grid.text(label='Note: Expected Percent calculated based on the 2010 6-Lines open observations.\nThe 54" lines delivered 71.6% (35.8% x 2) of the total REC flow on average',
            x=0.005,y=0.005,just=c('left','bottom'),gp=gpar(fontsize=9))
}
