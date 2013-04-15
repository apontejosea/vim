FillRowGaps  <-  function(x, colseq, col=1)  {
# TODO: Will probably need to implement this function in order to use it 
# in the above function. This is to return all the quarters and not 
# just the available quarters.
  stopifnot(is.character(col) | is.numeric(col))
  stopifnot(length(col) == 1)
  stopifnot(class(x[,col][1]) %in% class(colseq))
  if(is.character(col))
    col      <-  which(colnames(x)==col)
  
  df1        <-  as.data.frame(colseq)
  df2        <-  x
  names(df1) <-  names(df2)[col]

  result     <-  merge(df1, df2, all.x=T)

  return(result[,names(x)])
}
