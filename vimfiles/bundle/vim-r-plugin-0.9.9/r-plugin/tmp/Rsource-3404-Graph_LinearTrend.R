Graph_LinearTrend  <-  function(
  field='Delta',
  groupBy='Lines',
  from=as.chron('2004-01-01'),
  to=as.endOfYear(as.chron(Sys.Date())),
  data=get('tcd', envir=globalenv()), 
  ylab=NULL, ylim=c(-10,10), 
  displayEqn=FALSE,
  main=field) {

  # library(lattice)
  myFilter  <-  with(data, 
                     Dates >= as.chron('1999-12-31') 
                     & Lines != -999 
                     & Outliers == FALSE)
  
  if(is.null(ylab)) ylab<-field
  
  
  # This panel is shared by all of the graphs defined herein. 
  # It takes care of handling details such as:
  # - Graph colors by data groups
  # - Legend definition
  # - Plot the trendline
  # @param x 
  # @param y 
  # @param dateRange 
  # @param col 
  # @param displayEqn 
  # @param ... 
  # @return
  # @author Jose Aponte \email{jose.aponte@@arcadis-us.com}
  # @export
  panel.lm  <-  function(x,y,dateRange=c(min(x),max(x)),col,displayEqn=FALSE,...)
  {
    library(lattice)
    
    myData    <-  data.frame(x=x, y=y)
    myFilter  <-  with(myData, x >= dateRange[1] & x <= dateRange[2])
    
    mod       <-  lm(y ~ x, data=myData[myFilter,])
    m         <-  coef(mod)[2]
    b         <-  coef(mod)[1]
    myYs      <-  m*as.numeric(dateRange)+b
    
    minDate   <-  as.POSIXct(min(x), origin='1970-01-01')
    maxDate   <-  as.POSIXct(max(x), origin='1970-01-01')
    years     <-  seq(format(minDate,'%Y'), format(maxDate,'%Y'))
    years     <-  c(years, years[length(years)]+1)
    
    panel.abline( v=as.numeric(as.POSIXct(paste(years,'-01-01',sep=''))), 
        col='gray')
    panel.grid(h=-5,v=0,col='gray')
    
    panel.xyplot(x,y,...)
    panel.lines(x=as.numeric(dateRange), y=myYs, col=col)
    if(displayEqn)  {
      panel.text(mean(c(minDate, maxDate)), 
          mean(y,na.rm=T)+10, 
          paste('Driving Head = ', 
              round(coef(mod)[2],10), 
              ' * Date + ', 
              round(coef(mod)[1],2), 
              sep=''), 
          col=col)  
    }
  }
  
  param     <-  trellis.par.get('superpose.symbol')
  param$col <-  c('#FF5842','#6699FF','#FF9900','#33CC33','#EBEB33')
  trellis.par.set('superpose.symbol', param)
  
  
  myPlot  <-  xyplot(as.formula(
      paste(field, ' ~ as.chron2POSIXct(Dates)',sep='')), 
      data=data[myFilter,], groups=data[myFilter,groupBy], 
      auto.key=list(columns=5,title=groupBy),
      main=main,
      ylab=ylab,
      xlab='',
      ylim=ylim,
      strip=strip.custom(strip.levels=TRUE),
      as.table=TRUE,
      panel=panel.superpose,
      col=param$col,
      panel.groups=panel.lm,
      dateRange=as.chron2POSIXct(c(from,to)),
      displayEqn=displayEqn
  )

  print(myPlot)
}
