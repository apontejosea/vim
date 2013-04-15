grobMeanDevVsTime <-  function( 
    dates=tcd$Dates[myFilter], 
    signal=tcd$E1[myFilter], 
    target            = mean(signal, na.rm=TRUE),
    segmentColSignal  = '#9EBCE2',  
    segmentColTarget  = '#F4ABAB',  
    linesCol          = ifelse(signal > target, segmentColSignal, segmentColTarget),
    segmentStyle      = gpar(col=linesCol, lwd=3,lineend='square'),
    pointsColSignal   = '#007DCF',  pointsColTarget = '#C55052',
    myPch             = 19,
    symbolSize        = unit(.005, 'npc'),
    drawXAxis         = TRUE,
    myAtX             = seq(min(dates, na.rm=TRUE), max(dates,na.rm=TRUE), by="months"),
    myAtY             = seq(signif(min(c(target,signal),na.rm=TRUE),1), signif(max(c(target,signal),na.rm=TRUE),1), 100),
    myXLabels         = format(myAtX, '%b %Y'),
    ylab              = 'Percent Flow, mgd',
    ylabStyle         = gpar(),
    draw              = TRUE,
    plab              = NULL
)  {

  library(grid)

  
  if(is.null(myAtY))  h   <-  unit(seq(0.25, 0.75, 0.25), "npc")
  else                h   <-  unit(myAtY,'native')
  
  grillGrb                <-  grid.grill(v=unit(myAtX, 'native'),h=h)
  rectGrb                 <-  rectGrob(gp=gpar(lwd=2))
  
  segGrb      <-  segmentsGrob(
      x0=as.numeric(dates), 
      x1=as.numeric(dates), 
      y0=target, 
      y1=signal, 
      default.units='native',
      gp=segmentStyle)
  pnt1Grb     <-  pointsGrob(
      dates, 
      signal,   
      pch=myPch, 
      size=symbolSize, 
      gp=gpar(col=pointsColSignal))
  avgLineGrb  <-  linesGrob(
      x=unit(c(0,1),'npc'),
      y=unit(rep(target,2),'native'), 
      gp=gpar(col='red', lwd=3))
  avgTextGrb  <-  textGrob(
      label=paste(format(target, digits=2,nsmall=1), '%', sep=''), 
      x=unit(.5,'npc'), 
      y=unit(target, 'native')+unit(.6, 'lines'),
      gp=gpar(col='red'))
  
  if(drawXAxis) {
    xAxGrb    <-  xaxisGrob(at=myAtX, label=myXLabels, edits=gEdit("labels", rot=45))
    #grid.edit("xaxis1::labels",  rot=90)
    #xlabGrb    <-  textGrob('Year', y=unit(-3, 'lines'))
  }
  else {
    xAxGrb    <-  NULL
    xlabGrb   <-  NULL
  }
  
  yAxGrb      <-  yaxisGrob(at=myAtY)
  ylabGrb     <-  NULL
  
  if(!is.null(plab)) {
    grid.rect(
        x = unit(0,'npc'), 
        y = unit(1, 'npc'), 
        width = unit(3, 'lines'), 
        height = unit(1, 'lines'), 
        just = c('left','top'), 
        gp = gpar(fill='white'))
    plabGrob  <-  grid.text(label=plab,x=unit(.02,'npc'), y = unit(.97, 'npc'),just=c('left','top'))
  }
  else {
    plabGrob  <-  NULL
  }
  gt          <-  grobTree(xAxGrb, grillGrb,rectGrb,segGrb,pnt1Grb,avgLineGrb,yAxGrb,ylabGrb,avgTextGrb, plabGrob)
  
  if(draw) {
    grid.draw(gt)
  }
  invisible(gt)
}
