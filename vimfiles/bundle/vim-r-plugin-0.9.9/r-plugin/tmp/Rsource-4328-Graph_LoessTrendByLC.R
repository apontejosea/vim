Graph_LoessTrendByLC  <-  function(
    field='RECDev',
    from=as.chron('1980-01-01'), 
    to=as.chron(Sys.Date()),
    main=NULL,
    data=tcd) {
  
  myFilter  <-  with(data, 
                    Lines %in% c(3)
                    & Dates >= from
                    & Dates <= to
                    & Outliers == FALSE & LineCombination!="")
  
  param     <-  trellis.par.get('superpose.symbol')
  param$pch <-  rep(1,7)
  param$col <-  rainbow(4)
  trellis.par.set('superpose.symbol',param)
  
  param     <-  trellis.par.get('superpose.line')
  param$pch <-  rep(1,7)
  param$col <-  rainbow(4)
  trellis.par.set('superpose.line',param)
  
  panel.custom  <-  function(x,y,...)  {
    panel.xyplot(x,y,...)
    panel.abline(h  = seq(-500,500,2.5),
                 v  = as.chron(seq(as.chron2POSIXct('1985-01-01'),
                          as.chron2POSIXct(to),
                          "years")),
                 col='gray')
    panel.loess(x,y,span=1.1,...)
  }
  
  plt  <-  xyplot( as.formula(paste(field, ' ~ Dates',sep='')), 
      groups=as.LCFactor(LineCombination), 
      data=data[myFilter,], 
      layout=c(1,1,1),
      auto.key=TRUE,
      main=main, 
      ylim=extendrange(data[myFilter,field],f=.5),
      ylab=GetDataLabels(field),xlab='',
      panel=panel.superpose, panel.groups=panel.custom)
  
  print(plt)
}
