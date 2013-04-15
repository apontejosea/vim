Check <- function(pkg)  {
  require(devtools)
  shell(paste('R --vanilla CMD check ', pkg, sep=''))
}
