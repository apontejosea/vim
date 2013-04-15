GetUnits <- function(fields) {
  # LATER: should externalize this somehow at some point in the future.
  recordFields  <-  c("Dates","Outliers","RECQ","Sh9Q","Sh5AQ","Delta","Rondout","WestBranch",
                      "E1","W1","E2","W2","E3","W3","YearQtr","Lines","OperationGroups",
                      "LineCombination","Prediction","RECDev","RECPDev","Sh9Dev","Sh9PDev",
                      "RECPDelta","Sh9PDelta","DrivingHead",
                      "Sh1HGL", "Sh2AHGL", "Sh5AHGL", "Sh6HGL", "Sh8HGL", "Sh9HGL")
  recordUnits   <-  c("","","mgd","mgd","mgd","mgd","ft","ft","mgd","mgd","mgd","mgd","mgd",
                      "mgd","","","","","mgd","mgd","","mgd","","","","ft",
                      "ft","ft","ft","ft","ft","ft")
  
  areInRF <-  fields %in% recordFields
  if(!all(areInRF)) {
    stop(paste(fields[which(!areInRF)], 'are not part of the available fields in tcd data.frame', collapse=', '))
  }
  df <- as.data.frame(recordUnits,row.names=recordFields)
  return(as.character(df[fields,]))
}
