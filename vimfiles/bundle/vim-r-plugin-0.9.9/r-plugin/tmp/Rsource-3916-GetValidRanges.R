GetValidRanges  <-  function(fields)  {
  myRanges  <-  list(
      RECQ    =c(   0, 1000), 
      Sh9Q    =c(   0, 1000), 
      RECQDev =c(-200,  200), 
      Sh9QDev =c(-200,  200),
      DeltaQ  =c(-200,  200),
      Sh1HGL  =c(0, 1000),
      Sh9HGL  =c(0, 1000),
      DeltaHGL=c(100, 500),
      fREC    =c(0, 0.02),
      fSh9    =c(0, 0.02),
      Rondout = c(700, 900),
      WestBranch=c(200, 600),
      DrivingHead=c(100, 350),
      DeltaHGL=c(100, 350))
  stopifnot(fields %in% names(myRanges))
  myRanges[fields]
}
