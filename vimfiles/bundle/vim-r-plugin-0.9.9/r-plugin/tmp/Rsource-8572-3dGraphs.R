library(rgl)
library(DailyData)

myFilter <- with(tcd,  Outliers == FALSE & 
                       Lines == 6 & 
                       Dates >= as.chron('2000-01-01'))

with(tcd[myFilter,], plot3d(x=Dates,y=DrivingHead,z=Delta))
