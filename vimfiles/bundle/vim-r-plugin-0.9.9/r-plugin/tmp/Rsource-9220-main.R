setMethod("initialize", signature(.Object="BFData"),
  function(folder, .Object="BFData", ...) {
    library(Backflow)

    browser()
    my.data <- ReadBFData(folder, 0, 30, verbose = FALSE)
    .Object <-  DF(my.data)

    stopifnot(names(.Object) == c('DateTime', 'Flow', 'ElapsedHours', 'ElapsedDays', 'EventID'))
    stopifnot('chron' %in% class(.Object$DateTime))
    stopifnot(class(.Object$Flow) == 'numeric')
    stopifnot(class(.Object$ElapsedHours) == 'numeric')
    stopifnot(class(.Object$ElapsedDays) == 'numeric')
    stopifnot(class(.Object$EventID) == 'factor')

    invisible(.Object)
  }
)

