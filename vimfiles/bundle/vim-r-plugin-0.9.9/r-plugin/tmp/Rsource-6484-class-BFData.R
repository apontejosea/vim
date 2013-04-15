setValidity('BFData', validityBFData)

setMethod("initialize", signature(.Object="BFData"),
  function(.Object="BFData") {
    # my.data <- ReadBFData(folder, 0, 30, verbose = FALSE)
    # invisible(.Object)

    value <- callNextMethod()
    validObject(value)
    value
  }
)

