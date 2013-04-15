GetReportLabels <- function(fields) {
  # LATER: should externalize this somehow at some point in the future.
  recordFields  <-  c("Dates","Outliers","RECQ","Sh9Q","Sh5AQ","Delta","Rondout","WestBranch",
                      "E1","W1","E2","W2","E3","W3","YearQtr","Lines","OperationGroups",
                      "LineCombination","Prediction","RECDev","RECPDev","Sh9Dev","Sh9PDev",
                      "RECPDelta","Sh9PDelta","DrivingHead",
                      "Sh1HGL", "Sh2AHGL", "Sh5AHGL", "Sh6HGL", "Sh8HGL", "Sh9HGL")
  recordLabels  <-  c("Dates","Outliers","RECQ","Shaft9Q","Shaft5AQ","DeltaQ","RondoutRes.El.",
                      "WestBranchRes.El.","E1","W1","E2","W2","E3","W3","Year\nQtr.","Lines",
                      "OperationGroups","LineCombination","1956FlowCapacity","RECQDeviation",
                      "REC%Deviation","Shaft9QDeviation","Shaft9%Deviation","REC%Delta",
                      "Shaft9%Delta","DrivingHead",
                      "Shaft 1 HGL", "Shaft 2A HGL", "Shaft 5A HGL", "Shaft 6 HGL",
                      "Shaft 8 HGL", "Shaft 9 HGL")
  
  areInRF <-  fields %in% recordFields
  if(!all(areInRF))
  {
    stop(paste(fields[which(!areInRF)], 'are not part of the available fields in tcd data.frame', collapse=', '))
  }
  df <- as.data.frame(recordLabels,row.names=recordFields)
  return(as.character(df[fields,]))
}
