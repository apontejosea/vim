panel.MonthByOutliers  <-  function(x, y, fields, subscripts=subscripts, ...)  {
  options('warn'=0)
  begOfDays   <-  -1:33
  hLines      <-  fieldGridLines[[fields[current.row()]]]
  panel.abline(v=begOfDays, col='gray')
  panel.abline(h=hLines,    col='gray')
  panel.xyplot(x, y, cex=.4, subscripts=subscripts, ...)
}
