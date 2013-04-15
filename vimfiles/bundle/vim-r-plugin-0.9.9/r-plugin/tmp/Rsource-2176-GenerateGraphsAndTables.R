cat('fREC\n')
print(DailyData::Table_LineWiseYearlySummary(data=tcd,
                                             from=as.chron('2000-01-01'),
                                             to=rp.to , field='fREC', rnd=4,
                                             lines = c(2,3,4,6)))
cat('fSh9\n')
print(DailyData::Table_LineWiseYearlySummary(data=tcd,
                                             from=as.chron('2000-01-01'),
                                             to=rp.to , field='fSh9', rnd=4,
                                             lines = c(2,3,4,6)))
