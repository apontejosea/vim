brks <- with(tcd[myFilter,], 
             seq(min(DrivingHead,na.rm=T), max(DrivingHead,na.rm=T),
                 length.out = 33))
grps <- with(tcd[myFilter,], 
             cut(DrivingHead, 
                 breaks = brks, 
                 include.lowest = TRUE))
