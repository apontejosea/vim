library(rgl)
library(DailyData)


myFilter <- with(tcd,  Outliers == FALSE & 
                       Lines == 6 & 
                       Dates >= as.chron('2000-01-01'))
tcd$OG <- as.factor(as.chron(tcd$OperationGroups))


# brks <- with(tcd[myFilter,], 
#              seq(min(OG,na.rm=T), max(OG,na.rm=T),
#                  length.out = 23))
# grps <- with(tcd[myFilter,],
#              cut(OG,
#                  breaks = brks,
#                  include.lowest = TRUE))
# cols <- topo.colors(n=22, alpha = 1)[tcd$OG]


cols         <- brewer.pal(11, 'Spectral')[as.numeric(tcd$OG) %% 23]
xAxisLabels  <- with(tcd[myFilter,], unique(as.begOfYear(Dates)))


with(tcd[myFilter,], plot3d(x=Dates,y=DrivingHead,z=Delta, col=cols))
bbox3d(xat=xAxisLabels, xlab=as.character(years(xAxisLabels)))

