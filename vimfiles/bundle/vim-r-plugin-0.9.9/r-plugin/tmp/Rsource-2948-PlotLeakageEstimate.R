#' Plots backflow data
#' 
#' Plots backflow data bfd from the point where oscillations are within
#' -100 and 100 mgd, along with the output of the model with the 5 model 
#' parameters in S.
#' 
#' @export
#' 
#' @param eventID   id of the event to extract and plot from the main backflow data.frame (BFData by default)
#' @param data      BFData data.frame
#' @param params    bfParams data.frame
#' 
#' @return          Output through the active graphic device.
#' @author Jose Aponte \email{jose.aponte@@arcadis-us.com}
PlotLeakageEstimate <-  function(
    eventID='20030116', 
    data=get('BFData', envir=globalenv()), 
    params=get('bfParams', envir=globalenv()))  {
  
  # Specifying colors
  dataCol       <-  'green'
  modelCol      <-  'black'
  tmrLeakageCol <-  'red'
  trainingColor <-  '#FF000033'
  sh5AOnCol     <-  '#00FF0033'
  sh5AOffCol    <-  '#0000FF33'
  myYLim        <-  c(-100,100)
  
  # Loading and filtering data
  ind           <-  which(params$EventID==eventID)
  S             <-  params[ind,c('alpha','beta','chi','delta','epsilon')]
  bfd           <-  ExtractSingleEvent(eventID)
  method        <-  params$Method[ind]

  leakage       <-  params$TMRLeakage[params$EventID==eventID]
  trainingRanges<-  ExtractDataRanges(eventID=eventID, type=c('train'))
  sh5AOffRanges <-  ExtractDataRanges(eventID=eventID, type=c('Sh5AOff'))
  sh5AOnRanges  <-  ExtractDataRanges(eventID=eventID, type=c('Sh5AOn'))
  #myFilter      <- with(bfd, ElapsedHours/24 >= trainingRanges$from[1] &
  #  ElapsedHours/24 <= trainingRanges$to[1])
  
  # Plotting
  with(bfd, plot(ElapsedHours/24, Flow, pch=19, cex=.4,col=dataCol,
          xlab='Elapsed Days', ylab='Flow, mgd',
          main=EventID2DateChar(eventID), xlim=c(0,1), 
          ylim=myYLim))
  
  if(method == 'MOD')  {
    rect(xleft=trainingRanges$from, ybottom=rep(-1000, nrow(trainingRanges)),
        xright=trainingRanges$to, ytop=rep(1000, nrow(trainingRanges)), 
        col = trainingColor, border=trainingColor)
    text((trainingRanges$from+trainingRanges$to)/2, myYLim[2]-10, labels='Model Calibration\nRange', adj=c(0,0.5), srt=-90, cex=0.6)
  }
  if(nrow(sh5AOffRanges) > 0) {
    rect(xleft=sh5AOffRanges$from, ybottom=rep(-1000, nrow(sh5AOffRanges)),
        xright=sh5AOffRanges$to,  ytop=rep(1000, nrow(sh5AOffRanges)), 
        col = sh5AOffCol, border=sh5AOffCol)
    text((sh5AOffRanges$from+sh5AOffRanges$to)/2, myYLim[2]-50, labels='Shaft 5A Off', adj=c(0,0.5), srt=-90, cex=0.6)
  }
  
#  if(nrow(sh5AOnRanges) > 0) {
#    rect(xleft=sh5AOnRanges$from, ybottom=rep(-1000, nrow(sh5AOnRanges)),
#        xright=sh5AOnRanges$to, ytop=rep(1000, nrow(sh5AOnRanges)),
#        col = sh5AOnCol, border=sh5AOnCol)
#  }
  if(method == 'MOD')  {
    with(bfd, 
        lines(seq(0,1.5,.005), QModel(seq(0,1.5,.005), S),col=modelCol))
  }
  
  lines(c(0,60),rep(leakage,2),col=tmrLeakageCol)
  
  # Legend
  txt   <-  c(  paste('Reported Leakage: ',  round(leakage,1) ,sep=''),
                paste('Model Estimate: ',      round(S[[5]],1)     ,sep=''),
                'Shaft 9 Flow (Accusonic)')
  
  types     <-  c(  'l', 'l', 'p')
  col       <-  c(tmrLeakageCol,modelCol,dataCol)
  bfLegend(text=txt, type=types, col=col)
  
  # Event-specific comments
  bfComments(eventID, method=method)
}

# Produces and displays comments for specific events on the graph being produced.
bfComments  <-  function(eventID, method)
{
  globalComments    <-  paste('Selected estimation method: ', method, sep='')
  specificComments  <-  switch(eventID,
          '20100113'=
              'Leakage estimate was adjusted with 3 mgd average withdrawal',
          '20100603'=
              'Model output was affected by Shaft 5A withdrawals',
          # Default
          '')
  comments          <-  paste(globalComments, specificComments, sep='\n')
  
  # this draws the comments into the graphical display
  xleft             <-  1
  horizSpace        <-  .001
  vertSpace         <-  3
  fontSize          <-  .8
  alignment         <-  c(1,0)
  text(xleft-horizSpace, -100+vertSpace, comments, adj=alignment,cex=fontSize)
}

# Produces and displays the backflow plot legend
bfLegend  <-  function(xleft=.35, ytop=95, textSize=.8, 
    col=c('green','blue','red'), 
    text=c('TMR Estimate','model','data'), 
    type=c('l','l','p'))
{
  horizSpace  <-  .1
  vertSpace <-  10
  
  rect(xleft=xleft,ybottom=ytop-vertSpace*(length(text)+1),
      xright=1,ytop=95,col='white',border='black')
  
  alignment <-  c(0,xleft)
  
  for(i in 1:length(text))
  {
    if(type[i]=='l') {
      lines(x=c(xleft+.01,xleft+horizSpace-.01),
          y=rep(ytop-(vertSpace*i),2), col=col[i])
    }
    else if(type[i]=='p') {
      points(x=(2*xleft+horizSpace)/2,
          y=ytop-(vertSpace*i), 
          col=col[i],pch=19,cex=.8)      
    }
    
    text(xleft+horizSpace, 
        ytop-(vertSpace*i), text[i], cex=textSize, adj=alignment)
  }
}
