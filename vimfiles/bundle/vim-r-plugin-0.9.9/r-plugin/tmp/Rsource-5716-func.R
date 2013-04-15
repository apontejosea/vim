Graph_HistoricalTrend <- function(field, 
                                  lines.open = 4, 
                                  sData,
                      pred.range = as.chron(c('2011-01-01', '2011-12-31')),
                      fit.years = 5)  {
  
  # Select all available data from 5 years before the desired prediction dates
  fit.range  <-  c(YearLag(pred.range[1], y=-fit.years), pred.range[1]-1)
  
  fit.filter <-  with(sData, Lines == lines.open & Outliers == FALSE & 
                      Dates >= fit.range[1] &
                      Dates <= fit.range[2])
  
  pred.filter<-  with(sData, Lines == lines.open & Outliers == FALSE & 
                      Dates >= pred.range[1] &
                      Dates <= pred.range[2])
  
  if(sum(fit.filter)<=0) {
    warning(paste('no data to fit on the last ', fit.years, 
                  ' years of historical data', sep=''))
    p        <- ggplot()
    dummyData<- data.frame(Dates=as.Date(c(fit.range[1], pred.range[2])),
                                          Delta=c(1,1))
    p        <- p + geom_point(data=dummyData, 
                          aes(x=as.Date(Dates), y=Delta),
                          color='transparent')
    txt.all  <- data.frame(txt = 'No data available to fit a model', 
                          x = mean(as.Date(as.numeric(dummyData$Dates))), y = dummyData$Delta)
    p        <- p + geom_text(aes(label=txt,x=x, y=y, hjust = 0.5),
                                 data=txt.all, size=3)
  }
  else {
    # data     <-  data[, c('Dates', field, 'OperationGroups')]
    
    fit.dt   <-  seq(fit.range[1],  fit.range[2], by='day')
    pred.dt  <-  seq(pred.range[1], pred.range[2], by='day')

    modl     <-  paste(field, ' ~ Dates', sep='')
    modelFit <-  lm(eval(modl), data=sData[fit.filter,])

    pred.data<-  data.frame(Dates=c(fit.dt, pred.dt))
    p99      <-  predict(modelFit, pred.data,
                                 interval="prediction", level=0.99)
    p999     <-  predict(modelFit, pred.data,
                                 interval="prediction", level=0.999)
    pred.data<-  cbind(pred.data, p99, p999, deparse.level=2)
    names(pred.data)[2:4] <- paste('p99.', names(pred.data)[2:4], sep='')
    names(pred.data)[5:7] <- paste('p999.', names(pred.data)[5:7], sep='')





    p   <- ggplot()
    p   <- p + geom_point(data=data[fit.filter, ], aes(x=as.Date(Dates), y=Delta))
    p   <- p + geom_line(data=pred.data, aes(x=as.Date(Dates), y=p99.upr), color='blue')
    p   <- p + geom_line(data=pred.data, aes(x=as.Date(Dates), y=p99.fit), color='black')
    p   <- p + geom_line(data=pred.data, aes(x=as.Date(Dates), y=p99.lwr), color='blue')
    p   <- p + xlab('') + ylim(-25, 25)
    p   <- p + geom_point(data=data[pred.filter,], aes(x=as.Date(Dates), y=Delta), color='red')


    txt.formula   <- paste('Delta = ', round(coef(modelFit)['Dates'], 5),' * Date + ', 
                                       round(coef(modelFit)['(Intercept)'], 3), sep='')
    txt.rsq       <- paste('Adj-R^2 = ',
                           round(as.numeric(summary(mymod)['adj.r.squared']), 5), sep='')
    txt.all       <- data.frame(txt =paste(txt.formula, txt.rsq, sep='\n'), 
                                x = as.Date(fit.dt[1]), y = 20)

    p             <- p + geom_text(aes(label=txt,x=x, y=y, hjust = 0),
                                   data=txt.all, size=3)
  }
    p <- p + theme(axis.text.x=element_text(angle=-65, hjust = 0))

  return(p)
}
