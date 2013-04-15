PdfIt(print(xyplot(values~DrivingHeadModesFix|as.factor(Lines)*ind*Year,
                   auto.key=TRUE, groups=Modes, data=sData, layout=c(2, 3),  
             scales=list(y=list(relation='sliced'), x=list(relation='same')),
             type='p', xlab='Driving Head, ft\n(Adjusted by Sluice Gate Positions)', ylab='MGD',
             panel=panel.xywgrid)),
      file = 'out.pdf', dir = '.', width=11, height=17)
