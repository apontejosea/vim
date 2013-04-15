Graph_MonthByOutliers  <-  function(hts, fields = c('RECQ', 'Sh9Q', 'DeltaQ', 'RECQDev', 'Sh9QDev'))  {
  library(TimeUtils)
  library(Utility)

  # hts$YrMon           <-  as.factor(as.character(hts$YrMon))
  
  # Stacks Data
  dqColNames          <-  paste('DQ.', fields, sep='')
  carryovers          <-  c('NumDay', 'DateTime', 'Dates', 'YrMon', 'Lines', dqColNames)
  sData               <-  Stack(hts, 
                                    select    = fields,
                                    carryover = carryovers)
  
  names(sData)[names(sData)=='ind'] <-'Signal'
  sData$DQSignal      <-  paste('DQ.', sData$Signal, sep = '')
  sData$Signal        <-  ordered(sData$Signal, levels=fields)
  colInd              <-  pmatch(sData$DQSignal, names(sData), duplicates.ok = TRUE)

  stopifnot(all(dqColNames %in% names(sData)))
  
  # Check whether the DQ columns have NA, and if so, remove them
  sData               <-  FilterRowsWithNA(sData, dqColNames)

  # Returns an error whenever there are NA values in a DQ column
  stopifnot(!any(is.na(sData[,dqColNames])))

  sData  <-  StackDQMerge(sData, dqColNames)

  #  Create dummy values to make sure all data class combination has at least 1 value
  xCategories   <-  with(sData, expand.grid(YrMon=levels(YrMon), Signal=levels(as.factor(Signal))))
  rest          <-  CreateEmptyDataFrame(rows=1, cols=names(sData)[! names(sData) %in% names(xCategories)])
  rest$DateTime <-  as.chron(1.1)
  rest$values   <-  -1e5
  rest$NumDay   <-  0
  rest$Lines    <-  -999
  rest$DQ       <-  'DUMMY'

  browser()
  dm            <-  data.frame( repDF(rest, nrow(xCategories)), xCategories)
  
  # Append dummy values to data frame
  sData         <- rbind(sData, dm[, names(sData)])
  
  # Graph parameters
  sym     <-  trellis.par.get('superpose.symbol')
  lin     <-  trellis.par.get('superpose.line')
  sym$pch <-  1:15
  sym$col <-  c('black', rep('red', 14))
  lin$col <-  c('black', rep('transparent', 14))
  trellis.par.set('superpose.symbol',sym)
  trellis.par.set('superpose.line',lin)
#  lattice.options(panel.error="stop")
  lattice.options(panel.error=FALSE)
  
  # The OK state should always be part of the graphical output 
  myLevels  <-  unique(c('OK', as.character(sData$DQ)))
  
  nRow <-  length(fields)
  nCol <-  1

  xyplot(values ~ NumDay | I(as.factor(Signal)) * I(YrMon), 
      groups   = ordered(DQ, levels=myLevels, exclude='DUMMY'), 
      data     = sData, 
      type     = c('b'), 
      auto.key = list(title     = 'Outlier', 
                      columns   = max(1, min(c(length(myLevels)-1, 4))), 
                      border    = TRUE, 
                      cex.title = .9), 
      as.table = TRUE, 
      panel    = panel.MonthByOutliers,
      fields   = fields,
      scales   = list(x=list(at = seq(0, 30, 5)), y=list(relation='free')),
      ylim     = rep(GetValidRanges(fields)),

      xlim     = c(1, 32),
      layout   = c(nCol, nRow),
      xlab     = 'days', ylab=''
  )
      
}
