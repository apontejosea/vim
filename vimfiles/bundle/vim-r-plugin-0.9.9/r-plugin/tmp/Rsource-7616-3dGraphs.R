library(rgl)
library(DailyData)
library(TimeUtils)

myFilter <- with(tcd,  Outliers == FALSE & 
                       Lines %in% c(4) & 
                       Dates >= as.chron('2000-01-01') &
                       !is.na(Delta) & !is.na(DrivingHead))
tcd$OG   <- as.factor(as.chron(tcd$OperationGroups))
tcd$cols <- brewer.pal(12, 'Set3')[as.numeric(tcd$OG) %% 7 + 1]

xAxisLabels  <- with(tcd[myFilter,], CreateBOYVector(min(Dates), YearLag(max(Dates))))

with(tcd[myFilter,],
     plot3d(x=Dates,y=DrivingHead,z=Delta, size=8, 
            col=cols, 
            xlim=c(xAxisLabels[1], xAxisLabels[length(xAxisLabels)]),
            ylim=c(floor(min(DrivingHead)), ceiling(max(DrivingHead))),
            zlim=c(floor(min(Delta)), ceiling(max(Delta)))))

