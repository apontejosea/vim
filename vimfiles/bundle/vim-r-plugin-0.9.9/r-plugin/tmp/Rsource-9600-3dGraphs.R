availableLevels <- unique(tcd$OG[myFilter])
for(i in 1:length(availableLevels))  {
  localFilter  <- with(tcd, myFilter & as.character(OG) == as.character(availableLevels[i]))
  localCol <- cols[which(localFilter)]
  with(tcd[localFilter,], lines3d(x=Dates, y=DrivingHead, z=Delta,
                                  col=cols))
}
