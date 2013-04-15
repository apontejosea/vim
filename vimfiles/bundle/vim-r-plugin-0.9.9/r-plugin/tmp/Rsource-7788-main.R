print(xyplot(values~RECQ|ind*as.factor(Lines)*Year,auto.key=TRUE, 
             groups=Modes, data=sData, layout=c(3,1),
             scales=list(y=list(relation='sliced'), x=list(relation='sliced')),
             type='p', xlab='',
             panel=panel.xywgrid))
