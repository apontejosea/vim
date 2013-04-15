setGeneric("as.DF", function(x){ standardGeneric ("as.DF")})
setMethod('as.DF', 'data.frame', function(x) {new('DF', x)})

setMethod("initialize", signature(.Object="DF"),
  function(.Object, ...) {
    .Object <- callNextMethod(.Object, ...)
    invisible(.Object)
  }
)

