PdfIt(print(xyplot(values~t|ind*as.factor(Lines)*Year,auto.key=TRUE, 
             groups=Modes, data=sData, layout=c(2,5),
             scales=list(y=list(relation='free'), x=list(relation='same')), type='p')),
      file = 'out.pdf', dir = '.', width=11, height=17)
