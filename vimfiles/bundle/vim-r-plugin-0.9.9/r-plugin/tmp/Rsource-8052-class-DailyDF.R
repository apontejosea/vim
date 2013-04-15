
setGeneric('recentVsHistorical', function(x, ...) { standardGeneric('recentVsHistorical') })
setMethod('recentVsHistorical', 'DailyDF',
            function(x, from, to, fields, lines) {
              library(DailyData)
              qtr <- Table_QtrSummary(data = x, 
                                      from = from, 
                                      to = to, 
                                      fields = fields, 
                                      lines = lines, 
                                      paired.data = TRUE, 
                                      rnd = 1, use.row.names=TRUE)
              yr1 <- Table_NYearSummary(data = x, 
                                        fields = fields, 
                                        from = from, 
                                        y = 1, 
                                        lines = lines, 
                                        paired.data = TRUE, 
                                        rnd = 1, use.row.names=TRUE)
              yr5 <- Table_NYearSummary(data = x, 
                                        fields = fields, 
                                        from = from, 
                                        y = 5, 
                                        lines = lines, 
                                        paired.data = TRUE, 
                                        rnd = 1, use.row.names=TRUE)
              yr10 <- Table_NYearSummary(data = x, 
                                         fields = fields, 
                                         from = from, 
                                         y = 10, 
                                         lines = lines, 
                                         paired.data = TRUE, 
                                         rnd = 1, use.row.names=TRUE)
              return(rbind(qtr, yr1, yr5, yr10))              
            })

