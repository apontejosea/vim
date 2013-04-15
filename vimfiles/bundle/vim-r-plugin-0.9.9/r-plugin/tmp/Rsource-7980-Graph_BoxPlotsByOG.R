Graph_BoxPlotsByOG  <-  function(lines=6, data=tcd, 
                                 from = as.chron('2000-01-01'),
                                 to = as.chron('2010-12-31'),
                                 dummy.values = c(NA,NA,-15, 800))  {

  data$OperationTimeFrame  <-  with(data, 
                                    CalculateOperationTimeFrames(OperationGroups,
                                                                 OperationGroups2))

  myFilter <- with(data, Lines==lines & Outliers == FALSE & 
                   Dates >= as.chron('2000-01-01'))

  fields <- 'Rondout'
  p1 <- Graph_MultiVarBPlot(fields, data=data[myFilter,], 
                            by = 'OperationTimeFrame', 
                            printXAxis=F, yLab='ft',
                            dummy.value = dummy.values[1],
                            signal.labels = GetDataLabels(fields))

  fields <- 'DrivingHead'
  p2 <- Graph_MultiVarBPlot(fields, data=data[myFilter,], 
                            by = 'OperationTimeFrame', 
                            printXAxis=F, yLab='ft',
                            dummy.value = dummy.values[2],
                            signal.labels = GetDataLabels(fields))

  fields <- c('Delta','Sh5AQ')
  p3 <- Graph_MultiVarBPlot(fields, data=data[myFilter,], 
                            by = 'OperationTimeFrame', 
                            printXAxis=F, yLab='mgd',
                            dummy.value = dummy.values[3],
                            signal.labels = GetDataLabels(fields))
  fields <- c('RECQ', 'Sh9Q')
  p4 <-  Graph_MultiVarBPlot(fields, data=data[myFilter,], 
                             by = 'OperationTimeFrame', 
                             printXAxis=T, yLab = 'mgd', 
                             comments = 'Black dots represent extreme readings within the corresponding operation group.',
                             dummy.value = dummy.values[4],
                             signal.labels = GetDataLabels(fields))

   if(lines %in% 2){
     leftPadding  = c(    0,     0,   0.03,    0)
     rightPadding = c( 1.01,  0.72,      0, 1.18)
   } else if(lines %in% c(3,4)) {
     leftPadding  = c(    0,     0,   0.08,    0)
     rightPadding = c( 1.01,  0.72,      0, 1.18)
   } else if(lines == 6)  {
     leftPadding  = c(   0,    0,   0.14,  0)
     rightPadding = c( 1.01,  0.72,  0, 1.18)
   }
   
   LatticeStack(list(p1,p2,p3,p4), 
       heights      = c(.23, .23, .43,  .8),
       leftPadding  = leftPadding,
       rightPadding = rightPadding)
}
