  panel.lm  <-  function(x,y,dateRange=c(min(x),max(x)),col,...) {
    library(lattice)
    
    myData    <-  data.frame(x=x, y=y)
    myFilter  <-  with(myData, x >= dateRange[1] & x <= dateRange[2])
    
    # mod       <-  lm(y ~ x, data=myData[myFilter,])
    # m         <-  coef(mod)[2]
    # b         <-  coef(mod)[1]
    # myYs      <-  m*as.numeric(dateRange)+b
    
    minDate   <-  as.POSIXct(min(x), origin='1970-01-01')
    maxDate   <-  as.POSIXct(max(x), origin='1970-01-01')
    years     <-  seq(format(minDate,'%Y'), format(maxDate,'%Y'))
    years     <-  c(years, years[length(years)]+1)
    
    panel.abline( v=as.numeric(as.POSIXct(paste(years,'-01-01',sep=''))), 
        col='gray')
    # panel.grid(h=-5,v=0,col='gray')
    
    panel.xyplot(x,y,...)
    # panel.lines(x=as.numeric(dateRange), y=myYs, col=col)
    # if(displayEqn)  {
    #   panel.text(mean(c(minDate, maxDate)), 
    #       mean(y,na.rm=T)+10, 
    #       paste('Driving Head = ', 
    #           round(coef(mod)[2],10), 
    #           ' * Date + ', 
    #           round(coef(mod)[1],2), 
    #           sep=''), 
    #       col=col)  
    # }
  }
