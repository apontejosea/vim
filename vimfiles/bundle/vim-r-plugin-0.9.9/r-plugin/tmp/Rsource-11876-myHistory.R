PdfIt(print(xyplot(values~RECQ|as.factor(Lines)*as.factor(ind),groups=as.factor(Type),ylab='HGL, ft',xlab='REC Flow, mgd',
                   data=shgl.all, layout=c(1,1),panel=panel.custom,
                   scales=list(relation='free'), auto.key=T)))
