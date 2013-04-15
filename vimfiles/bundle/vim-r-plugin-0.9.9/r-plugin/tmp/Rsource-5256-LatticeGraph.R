library(lattice)
library(Utility)
library(DailyData)
Stack(x = tcd, select = c('Delta','DrivingHead','Rondout', ))

myFilter <- with(tcd,  Outliers == FALSE & 
                       Lines == 6 & 
                       Dates >= as.chron('2000-01-01'))

rp.from  <- as.chron('2011-01-01')

brks <- with(tcd[myFilter,], 
             seq(min(DrivingHead,na.rm=T), max(DrivingHead,na.rm=T),
                 length.out = 33))
grps <- with(tcd[myFilter,], 
             cut(DrivingHead, 
                 breaks = brks, 
                 include.lowest = TRUE))

cols <- terrain.colors(n=32, alpha = 1)[grps]

# cols <- rep('black', nrow(tcd))
# cols[tcd$Dates >= as.chron(rp.from)]   <- 'red'

hcFields <- c('Dates','DrivingHead','Delta','RECDev','Sh9Dev')
hdFields <- c('Dates','Rondout','Delta','RECDev','Sh9Dev')
plot(tcd[myFilter, hcFields], col=cols)
