setOldClass('data.frame')
setClass('DF', prototype=data.frame(), contains='data.frame')

DF <- function(...) {new('DF', data.frame(...))}

setGeneric("as.DF", function(x){ standardGeneric ("as.DF")})
setMethod('as.DF', 'data.frame', function(x) {new('DF', x)})

setMethod("initialize", signature(.Object="DF"),
  function(.Object, ...) {
    .Object <- callNextMethod()
    invisible(.Object)
  }
)

setGeneric('to_rda', function(x, ...) { standardGeneric('to_rda') })
setMethod('to_rda', 'DF', function(x, file)  {save(x, file=file)})

setGeneric('to_csv', function(x, ...) { standardGeneric('to_csv') })
setMethod('to_csv', 'DF', 
          function(x, file)  {
            write.csv(x, file, row.names = FALSE)
          })

setGeneric('to_tex', function(x, ...) { standardGeneric('to_tex') })
setMethod('to_tex', 'DF', 
          function(x, file) {
            library(xtable)
            xtable(a)
          })

setGeneric('to_gridTable', function(x, ...) {standardGeneric('to_gridTable')})
setMethod('to_gridTable', 'DF',
          function(x, file)  {
            library(gridExtra)
            grid.table(x)
          })

