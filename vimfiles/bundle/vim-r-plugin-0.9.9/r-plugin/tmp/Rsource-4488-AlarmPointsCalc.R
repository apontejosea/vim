CalculateHGLAlarms  <-  function(Dates, HGL, Lines)  {
  numLines  <-  c('1','2','3','4','6')
  result    <-  CreateEmptyDataFrame(cols=numLines, rows=c('HHH','HH','H','L','LL','LLL','SD'))
  for(i in 1:ncol(result))  {
    myFilter    <-  Lines==numLines[i]
    result[,i]  <-  AlarmPoints(Dates[myFilter], HGL[myFilter])
  }
  return(result)
}



###############################################################################
# Deviation   10 Year Standard Deviation
# High-High-High  HGL > [10 Year max] + [2*Deviation]
# High-High       HGL > [10 Year max] + [1*Deviation]
# High            HGL > [10 year max]
# Low             HGL < [10 year min]
# Low-Low         HGL < [10 year min] - [1*Deviation]
# Low-Low-Low     HGL < [10 year min] - [2*Deviation] 
# Author: Aponte
###############################################################################
AlarmPoints <-  function(Dates, HGL) {
  mod <-  lm(HGL~Dates)
  pred  <-  predict(mod, newdata=data.frame(Dates=as.chron('2011-09-01')))

  Dev     <-  sd(HGL,na.rm=T)
  
  HHH     <-  pred + 5*Dev
  HH      <-  pred + 4*Dev
  H       <-  pred + 3*Dev
  L       <-  pred - 3*Dev
  LL      <-  pred - 4*Dev
  LLL     <-  pred - 5*Dev

  result            <-  data.frame(Values=c(HHH,HH,H,L,LL,LLL,Dev))
  row.names(result) <-  c('HHH','HH','H','L','LL','LLL','SD')
  return(round(result, 1))
}
