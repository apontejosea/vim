GetModesData <-  function(dateVec, modes=modesTable)  {
  # List of modes available
  modesVec          <-  rep("", length(dateVec))
  
  for(i in 1:nrow(modes))
  {
    ind             <-  which(dateVec > modes$from[i] & dateVec <= modes$to[i])
    if(length(ind) > 0)
    {
      modesVec[ind] <-  as.character(modes$Mode[i])
    }
  }
  
  ind               <-  which(dateVec %in% dates(modes$from))
  modesVec[ind]     <-  "ModeChange"
  modesVec          <-  factor(modesVec)
  return(modesVec)
}
