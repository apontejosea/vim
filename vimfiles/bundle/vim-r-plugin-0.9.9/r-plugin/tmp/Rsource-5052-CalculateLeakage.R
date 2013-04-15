CalculateLeakage <- function(HTData,svData=get('svData', envir=globalenv())) { 

  # Calculating corresponding interpolated volume for each HGL in the HTData dataset
  interpResult    <- Storage2Volume(HTData, svData)
  
  # Calculating the average HGL values of each two consecutive HGL measurements used for leakage calculation. 
  currHGL         <- HTData$HGL[-nrow(HTData)]
  nextHGL         <- HTData$HGL[-1]
  leakHGL         <- (nextHGL+currHGL)/2
  
  # Preparing data for leakage calculation
  currVolVec      <- interpResult$y[-length(interpResult$y)]
  nextVolVec      <- interpResult$y[-1]
  currTimeVec     <- HTData$DateTime[-nrow(HTData)]
  nextTimeVec     <- HTData$DateTime[-1]
  leakageTime     <- as.chron((as.numeric(currTimeVec)+as.numeric(nextTimeVec))/2)
#  leakageTime     <- currTimeVec + as.numeric((nextTimeVec-currTimeVec)/2)

  # Leakage Calculation
  mgdLeakage      <- (nextVolVec-currVolVec)/1e6/(nextTimeVec-currTimeVec)
  mgdLeakage      <- as.numeric(mgdLeakage)
  
  # There is the suspicion that leakage calculations for two consecutive HGL measurements that fall on 
  # different slope segments of the tunnel (different rows of the svData table) produce outliers on the
  # leakage vs. HGL trend.  "isSameSegment" is a boolean vector that identifies the leakage calculations 
  # for which the two consecutive HGL values used fell within the same segment.
  S2VInd          <- findInterval(HTData$HGL, svData$Feet) # returns the index of the closest values in the table that is less than the test HGL value
  currS2VInd      <- S2VInd[-length(S2VInd)] 
  nextS2VInd      <- S2VInd[-1]
  isSameSegment   <- currS2VInd == nextS2VInd
  
  # This is the output of the function organized on a data.frame structure
  data.frame(DateTime=leakageTime,Leakage=mgdLeakage,HGL=leakHGL,PotentialOutlier=!isSameSegment)
}
