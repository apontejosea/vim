rect(xleft=rep(firstDate,5), 
    ybottom=unlist(alarms['L',]), 
    xright=rep(as.numeric(lastDate), 5),
    ytop=alarms['H',],
    col=myColors[3])
