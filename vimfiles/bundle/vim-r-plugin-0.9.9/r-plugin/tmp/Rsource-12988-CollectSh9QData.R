CollectSh9QData  <-  function(file=choose.files())  {

  library(TimeUtils)
  library(zoo)

  # Functions needed to correct subtle roundoff differences between two zoo
  # object indices.
  rnd <- function(x) round(24 * 3600 * as.numeric(x) + 0.5) / (24 * 3600)
  Rnd <- function(x) {
    time(x) <- chron(rnd(time(x)))
    x
  }

  # browser()
  stopifnot(file != "")

  rawSh9Data  		        <- read.csv(file, header = FALSE)

  rawSh9Data              <- rawSh9Data[,1:2]
  names(rawSh9Data)       <- c('DateTime.Sh9', 'Sh9Q')
  rawSh9Data$DateTime.Sh9 <- xlDateTime2Chron(as.character(rawSh9Data$DateTime.Sh9))
  rawSh9Data$DateTime     <- TimeUtils::RoundHour(rawSh9Data$DateTime.Sh9)

  zooSh9Data              <- zoo(rawSh9Data, order.by=chron(rnd(rawSh9Data$DateTime)))

  from                    <- min(rawSh9Data$DateTime)
  to                      <- max(rawSh9Data$DateTime)
  dtVector                <- chron(rnd(TimeUtils::RoundHour(CreateChronVector(from, to))))
  dtZoo                   <- zoo(NA, order.by=dtVector)

  zRes                    <- merge.zoo(dtZoo, zooSh9Data)
  res                     <- data.frame(DateTime=index(zRes), as.data.frame(zRes),
                                        row.names=seq(1, nrow(zRes)))[,c('DateTime','DateTime.Sh9','Sh9Q')]
  res$DateTime.Sh9        <- as.chron(res$DateTime.Sh9)

  return(res)
}
