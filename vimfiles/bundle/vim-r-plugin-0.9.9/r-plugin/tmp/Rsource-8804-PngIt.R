PngIt <- function(myGraph, 
    file = paste( 'Output_', TimeStamp(), '.png', sep=''),
    multiplier=1, 
    width=11*multiplier, height=8.5*multiplier, res=200, verbose = TRUE)  {
  
  
  tryCatch({
        # attempts to open pdf stream to file 
        # could fail if the file is open
        png(file=file,
            width=width*multiplier, 
            height=height*multiplier,
            units='in', res=res)
        myGraph
        if(verbose) print(paste('Graph saved as ', file, sep=''))
      }, error=function(e) {
        message(e)
      },
      finally={
        try(dev.off(),silent=TRUE)
      })
}
