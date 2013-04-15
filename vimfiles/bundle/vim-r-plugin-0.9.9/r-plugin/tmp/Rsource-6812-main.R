PdfIt(print(xyplot(values~RECQ|ind*as.factor(Lines)*Year,auto.key=TRUE, 
             groups=Modes, data=sData, layout=c(3,5),
             scales=list(y=list(relation='sliced'), x=list(relation='sliced')),
             type='p',
             panel=panel.xywgrid)),
      file = 'out.pdf', dir = '.', width=11, height=17)
