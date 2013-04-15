PdfIt(print(xyplot(values~RECQ|ind*as.factor(Lines)*Year,auto.key=TRUE, 
             groups=Modes, data=sData, layout=c(3,4),
             scales=list(y=list(relation='sliced'), x=list(relation='sliced')),
             type='p', xlab='RECQ',
             panel=panel.xywgrid)),
      file = 'out.pdf', dir = '.', width=11, height=17)
