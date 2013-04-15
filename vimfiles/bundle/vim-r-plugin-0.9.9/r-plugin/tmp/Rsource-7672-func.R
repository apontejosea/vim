Graph_ParallelTrends <- function(
                        fields=c('DrivingHead', 'Rondout', 'Delta', 'RECDev', 'Sh9Dev'),
                        data=tcd,
                        cut.off.date = as.chron('2012-01-01'),
                        fit.years = 5)  {

  browser()
  library(ggplot2)
  library(chron)
  library(Utility)

  lines.open <- c(2, 3, 4, 6)
  myLabels <- c('Driving Head, ft', 'Rondout Elev., ft', 'Delta, mgd', 'RECDev, mgd','Sh9Dev, mgd')
  myFilter  <- with(data, Outliers == FALSE & 
                    Lines %in% lines.open & 
                    Dates >= YearLag(cut.off.date, -fit.years))

  sData     <-  Stack(x = data[myFilter, ], select = fields, 
                     carryover = c('Dates', 'Lines', 'Outliers'))

  sData$ind <- ordered(sData$ind, levels=fields, labels=myLabels)

  fit.data  <- sData[sData$Dates >= YearLag(d=cut.off.date, y=-fit.years) &
                     sData$Dates < cut.off.date,]

  ribbonData <- NULL
  for(i in levels(fit.data$ind))  {
    for(j in lines.open)  {
      sub.data        <- fit.data[fit.data$ind==i & fit.data$Lines==j,]
      lmFit           <- lm(values~Dates, data=sub.data)

      maxDiff         <- max(sub.data$values -  predict(lmFit, newdata=data.frame(Dates=sub.data$Dates)), na.rm=TRUE)
      minDiff         <- max(predict(lmFit, newdata=data.frame(Dates=sub.data$Dates)) - sub.data$values, na.rm=TRUE)

      lineProjData    <- data.frame(Dates=c(as.begOfYear(min(fit.data$Dates)),
                                            as.endOfYear(max(data$Dates))))
      nYearData       <- as.data.frame(predict(lmFit,
                                               newdata=lineProjData,
                                               interval='prediction'))
      nYearData$Min   <- nYearData[,'fit'] - minDiff
      nYearData$Max   <- nYearData[,'fit'] + maxDiff
      nYearData$Dates <- lineProjData$Dates
      nYearData$ind   <- rep(i, nrow(nYearData))
      nYearData$Lines <- rep(j, nrow(nYearData))
      ribbonData      <- rbind(ribbonData, nYearData)
    }
  }
  ribbonData$ind      <- ordered(ribbonData$ind, levels=myLabels)

  browser()

  p <- ggplot(data=sData)
  p <- p + facet_grid(ind ~ Lines, 
                      scales='free')
  p <- p + geom_ribbon(aes(x=as.Date(Dates), ymin=Min, ymax=Max), alpha=.5,
                       data=ribbonData)
  p <- p + geom_point(aes(x=as.Date(Dates), y=values),
                      color='blue')
  p <- p + geom_point(aes(x=as.Date(Dates), y=values),
                      data=sData[sData$Dates>=cut.off.date,],
                      color='red')
  p <- p + geom_line(aes(x=as.Date(Dates), y=fit), 
                     data=ribbonData, color='black', size=1)
  # p <- p + xlim(as.numeric(c(as.begOfYear(YearLag(cut.off.date, -fit.years)),
  #               as.endOfYear(max(data$Dates)))))
  # p <- p + scale_x_date(n=fit.years)
  p <- p + theme(axis.text.x=element_text(angle=-65, hjust = 0, vjust = 1))
  p <- p + ylab('') + xlab('')

  print(p)
}
