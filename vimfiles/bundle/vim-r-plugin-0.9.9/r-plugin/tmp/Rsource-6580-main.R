setGeneric('to_csv', function(x, ...) { standardGeneric('to_csv') })
setMethod('to_csv', 'DF', 
          function(x, file)  {
            library(DailyData)
            WriteDailyCSV(x, file = file)
          })


