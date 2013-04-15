PdfDoc <- function(pkg)  {
  require(roxygen2)
  Check(pkg)
  roxygenize(pkg)
  shell(paste('mv ', pkg, '.Rcheck', '/*-manual.pdf .', sep=''), 
        mustWork = TRUE)
  shell(paste('rmdir /S /Q ', pkg, '.Rcheck', sep=''))
}
