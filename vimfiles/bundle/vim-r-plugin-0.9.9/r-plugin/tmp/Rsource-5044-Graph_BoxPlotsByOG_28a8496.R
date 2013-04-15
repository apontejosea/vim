Graph_BoxPlotsByOG  <-  function(lines=6)  {
   p1 <-  Graph_BoxPlot(c('Rondout'), lines, 
       ylab = 'feet',
       printXAxis=F)
   p2 <-  Graph_BoxPlot(c('DrivingHead'), lines, 
       ylab = 'feet',
       printXAxis=F)
   p3 <-  Graph_BoxPlot(c('Delta','Sh5AQ'), lines, 
       ylab = 'mgd',
       printXAxis=F)
   p4 <-  Graph_BoxPlot(c('RECQ', 'Sh9Q'), lines,
       ylab = 'mgd',
       printXAxis=T,
       printComment=TRUE)

   if(lines %in% 2){
     leftPadding  = c(   0,    0,   0.03,  0)
     rightPadding = c( 1.01,  0.72,  0, 1.18)
   }
   else if(lines %in% c(3,4)) {
     leftPadding  = c(   0,    0,   0.08,  0)
     rightPadding = c( 1.01,  0.72,  0, 1.18)
   }
   else if(lines == 6)  {
     leftPadding  = c(   0,    0,   0.14,  0)
     rightPadding = c( 1.01,  0.72,  0, 1.18)
   }
   
   LatticeStack(list(p1,p2,p3,p4), 
       heights      = c(.23, .23, .43,  .8),
       leftPadding  = leftPadding,
       rightPadding = rightPadding)
}
