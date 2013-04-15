  p <- ggplot(data=sData)
  p <- p + geom_point(aes(x=Dates, y=values),
                      color='blue')
  p <-  p + facet_grid(ind ~ ., scales='free')
  p  <- p + scale_x_chron()
  p <-  p + stat_smooth(aes(x=Dates, y=values), 
                        fill="blue", colour="darkblue",
                        size=0.8, alpha=0.3)
  p <- p + geom_point(aes(x=Dates, y=values), 
                      data=sData[sData$Dates >= cut.off.date, ],
                      color='red')
  print(p)
