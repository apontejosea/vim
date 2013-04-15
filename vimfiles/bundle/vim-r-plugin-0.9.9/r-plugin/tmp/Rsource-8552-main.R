xyplot(RECDev~lRECDev|as.factor(Lines), groups=Year, data=X[myFilter,],
       as.table=TRUE)
