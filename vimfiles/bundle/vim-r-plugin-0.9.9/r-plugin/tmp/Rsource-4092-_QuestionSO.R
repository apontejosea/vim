  rnd <- function(x) round(24 * 3600 * as.numeric(x) + 0.5) / (24 * 3600)
  Rnd <- function(x) {
    time(x) <- chron(rnd(time(x)))
    x
  }
