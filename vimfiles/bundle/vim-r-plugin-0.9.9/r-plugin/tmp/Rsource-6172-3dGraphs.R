library(rgl)
library(DailyData)
library(TimeUtils)

myFilter <- with(tcd,  Outliers == FALSE & 
                       Lines %in% c(4) & 
                       Dates >= as.chron('2000-01-01') &
                       !is.na(Delta) & !is.na(DrivingHead))
tcd$OG   <- as.factor(as.chron(tcd$OperationGroups))
tcd$cols <- brewer.pal(12, 'Set3')[as.numeric(tcd$OG) %% 7 + 1]

# brks <- with(tcd[myFilter,], 
#              seq(min(OG,na.rm=T), max(OG,na.rm=T),
#                  length.out = 23))
# grps <- with(tcd[myFilter,],
#              cut(OG,
#                  breaks = brks,
#                  include.lowest = TRUE))
# cols <- topo.colors(n=22, alpha = 1)[tcd$OG]


xAxisLabels  <- with(tcd[myFilter,], CreateBOYVector(min(Dates), YearLag(max(Dates))))


with(tcd[myFilter,],
     plot3d(x=Dates,y=DrivingHead,z=Delta, size=8, 
            col=cols, 
            xlim=c(xAxisLabels[1], xAxisLabels[length(xAxisLabels)]),
            ylim=c(floor(min(DrivingHead)), ceiling(max(DrivingHead))),
            zlim=c(floor(min(Delta)), ceiling(max(Delta)))))

bbox3d(color=c("#333377", 'black'), 
       emission="#333377", 
       specular="#3333FF", 
       shininess=5, 
       alpha=c(0.2, 1),
       xat=xAxisLabels, 
       xlab=as.character(years(xAxisLabels)))

grid3d(side='x', at=list(x=xAxisLabels), col='black')
grid3d(side='y', at=list(x=xAxisLabels), col='black')
grid3d(side='z', at=list(x=xAxisLabels), col='black')

# grid3d('y', at=list(z=15), col='black')
# grid3d('z', at=list(z=15), col='black')

availableLevels <- unique(tcd$OG[myFilter])
for(i in 1:length(availableLevels))  {
  # browser()
  localFilter  <- with(tcd, myFilter & as.character(OG) == as.character(availableLevels[i]))
  localCol <- cols[which(localFilter)]
  with(tcd[localFilter,], lines3d(x=Dates, y=DrivingHead, z=Delta,
                                  col=cols))
}

bg3d('red')
movie3d(spin3d(c(1,0,0)), duration=14, type='gif')
