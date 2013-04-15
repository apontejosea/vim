Graph_MultiVarBPlot <- function(
                                fields  = c('x','y'), 
                                data    =
                                data.frame(x    = c(3, 2, 1, 4, NA, NA),
                                           y    = c(4, 5, 6, 7, 8, 9),
                                           c    = c('A','A','A','A','B','B')
                                           ), 
                                by        = 'c',
                                xLab      = by,
                                yLab      = 'value',
                                dummy.value = NULL,
                                printXAxis=T,
                                comments=NULL,
                                legend.text.width = 50,
                                signal.labels = fields
                                )  {
  stopifnot(length(by) == 1)
  stopifnot(length(fields) %in% 1:4)
  stopifnot(!('cat' %in% names(data)))
  stopifnot(by %in% names(data))
  stopifnot(all(fields %in% names(data)))
  stopifnot(is.ordered(data[,by]))

  tblSummary          <- t.medianminmax(fields  = fields, by      = by, data    = data)
  tblStack            <- Stack(data, select = fields, carryover = by)

  names(tblStack)[which(names(tblStack)==by)]     <- 'cat'
  names(tblSummary)[which(names(tblSummary)==by)] <- 'cat'

  ## not using this yet
  ## needed for the elimienation of data going to boxplots with small samples
  # smallSampleGroups   <- tblSummary[tblSummary$count < 1, by]


  # adding dummy data points to the tblStack data.frame
  myFun           <- function(x)  any(!is.na(x))
  validitySummary <- aggregate(x   = tblStack$values, 
                               by  = list(ind= tblStack$ind, 
                                          cat  = tblStack$cat), 
                               FUN = myFun)
  naInd           <- which(validitySummary$x == FALSE)
  if(length(naInd)>0)  {
    temp            <- data.frame(cat = validitySummary$cat[naInd],
                                  values = rep(dummy.value, length(naInd)),
                                  ind = validitySummary$ind[naInd])
    tblStack        <- rbind(tblStack, temp)
  }

  if(printXAxis)  {
    xAxisCol  <-  'black'
    xAxisSize <-  8
    xLab      <-  xLab
  }  else  {
    xAxisCol  <-  'transparent'
    xAxisSize <-  0.00001
    xLab      <-  NULL
  }

  names(tblSummary)[which(names(tblSummary)=='ind')]  <-  'Signal'
  names(tblStack)[which(names(tblStack)=='ind')]      <-  'Signal'

  # browser()
  
  tmpSignal         <- ordered(tblStack$Signal, levels=levels(tblStack$Signal), labels = signal.labels) 
  tblStack$Signal   <- tmpSignal
  # tblStack$Signal   <- expandblank(as.character(tmpSignal), legend.text.width)

  tmpSignal         <- ordered(tblSummary$Signal, levels=levels(tblSummary$Signal), labels = signal.labels) 
  tblSummary$Signal <- tmpSignal
  # tblSummary$Signal <- expandblank(as.character(tmpSignal), legend.text.width)

  p  <-  ggplot() +
      theme(
           plot.margin = unit(c(0,1.6,0,0.1), 'in'),
           # legend.key.size = unit(2, 'in'),
           # legend.text = GetDataLabels(as.character(unique(tblStack$Signal))),
           # legend.text.align = 'left',
           legend.position = c(1.13, 0.5),
           axis.text.x=element_text(angle=-90, hjust=0, size=xAxisSize,
                                 colour=xAxisCol),
          plot.margin = unit(c(0,0,0,0), "cm"))  +
      scale_colour_hue(guide='none') +
      xlab(xLab)
  p  <-  p + 
      ylim(range(tblStack$values, na.rm=TRUE))
  p  <-  p + 
      geom_line(
          aes(x=as.factor(cat), y=median, 
              ymin=min, ymax=max, 
              colour=Signal, group=Signal), 
          position=position_dodge(width=.60), 
          data=tblSummary,
          na.rm=T)
  p  <-  p + 
      geom_boxplot(
          aes(x=as.factor(cat), y=values, 
              fill=Signal), 
          position=position_dodge(width=.60), 
          data=tblStack,
          outlier.size = 1.2,
          na.rm=T)  +
    xlab(xLab) + 
    ylab(yLab)
  if(!is.null(dummy.value))  {
    lineData <- data.frame(x=c(0, length(unique(tblStack$cat)) + 1), y=rep(dummy.value,2))
    p  <-  p + 
    geom_line(aes(x=x, y=y), data=lineData, size = 1, col='white')
  }
  if(!is.null(comments))  {
    ldata <- data.frame(comments=comments,
                  min=min(tblSummary$min,na.rm=TRUE))
    p  <-  p + geom_text(size=4,
            aes(x=1,
                y=min,
                label=comments,
                hjust=0,
                vjust=0.5), data=ldata)
  }   

  return(p)
}
