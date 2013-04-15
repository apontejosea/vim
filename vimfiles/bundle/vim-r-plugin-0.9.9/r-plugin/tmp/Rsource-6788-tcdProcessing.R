data.dir  <-  'C:/workspace/NYCDEP/data/ProcessedData'
out.dir   <-  '.'

ProcessTCD(data.dir, out.dir, calcOG=TRUE)
load(file.path(out.dir, 'tcd.rda'))
