PdfIt <- function(myGraph, 
                  file = paste( 'Output_', TimeStamp(), '.pdf', sep=''),
                  multiplier=1, width=11, height=8.5, onefile=TRUE) {

  tryCatch( {
        # attempts to open pdf stream to file 
        # could fail if the file is open
    # pdf(file=paste(dir,'/',file,sep=''), 
    #     width=width*multiplier, 
    #     height=height*multiplier, onefile=onefile)

        pdf(file=file,
            width=width*multiplier, 
            height=height*multiplier, onefile=onefile)

        myGraph
        print('Done!')
      }, error=function(e) {
        message(e)
      },
      finally={
        try(dev.off(),silent=TRUE)
      })
}
