PdfIt({
      sym     <-  trellis.par.get('superpose.symbol')
      sym$pch <- 1:7
      trellis.par.set('superpose.symbol', sym)

      print(xyplot(values~t|as.factor(Lines)*ind*Year,
                   auto.key=TRUE, groups=Modes, data=sData, layout=c(2,
                                                                     length(myFields)),  
             scales=list(y=list(relation='sliced'), x=list(relation='same')),
             # type='p', xlab='Driving Head, ft\n(Adjusted by Sluice Gate Positions)', ylab='MGD',
             type='p', xlab='Day of the year', ylab='MGD',
             panel=panel.xywgrid, 
             as.table=TRUE))
},
      file = 'out.pdf', dir = '.', width=17, height=11)
