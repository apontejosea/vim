myFilter <- with(tcd,  Outliers == FALSE & 
                       Lines == 6 & 
                       Dates >= as.chron('2000-01-01'))
