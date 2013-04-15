pdf('HGLAlarmPoints.pdf', width=11, height=8.5)

Graph_LinearTrend('Sh1HGL', from=as.chron("2004-01-01"), to=as.chron("2011-05-31"), data=tcd,ylab='HGL', ylim=ylim1, displayEqn=T,main='Shaft 1 HGL Historical Trends')
stripplot(Sh1HGL ~  fac | factor(Lines), data = tcd2[myFilter,], layout = c(5,1), jitter.data = TRUE, factor = 2.8, panel=panel.alarms, alarms=alarms1, ylim=ylim1, main='Shaft 1 HGL Alarm Points for Different Line Open Conditions\n\n',sub='\n')

Graph_LinearTrend('Sh2AHGL',from=as.chron("2004-01-01"), to=as.chron("2011-05-31"), data=tcd,ylab='HGL', ylim=ylim2A, displayEqn=T,main='Shaft 2A HGL Historical Trends')
stripplot(Sh2AHGL ~ fac | factor(Lines), data = tcd2[myFilter,], layout = c(5,1), jitter.data = TRUE, factor = 2.8, panel=panel.alarms, alarms=alarms2A, ylim=ylim2A, main='Shaft 2A HGL Alarm Points for Different Line Open Conditions\n\n',sub='\n')

Graph_LinearTrend('Sh5AHGL',from=as.chron("2004-01-01"), to=as.chron("2011-05-31"), data=tcd,ylab='HGL', ylim=ylim5A, displayEqn=T,main='Shaft 5A HGL Historical Trends')
stripplot(Sh5AHGL ~ fac | factor(Lines), data = tcd2[myFilter,], layout = c(5,1), jitter.data = TRUE, factor = 2.8, panel=panel.alarms, alarms=alarms5A, ylim=ylim5A, main='Shaft 5A HGL Alarm Points for Different Line Open Conditions\n\n',sub='\n')

Graph_LinearTrend('Sh6HGL',from=as.chron("2004-01-01"), to=as.chron("2011-05-31"), data=tcd,ylab='HGL', ylim=ylim6, displayEqn=T,main='Shaft 6 HGL Historical Trends')
stripplot(Sh6HGL ~  fac | factor(Lines), data = tcd2[myFilter,], layout = c(5,1), jitter.data = TRUE, factor = 2.8, panel=panel.alarms, alarms=alarms6,, ylim=ylim6, main='Shaft 6 HGL Alarm Points for Different Line Open Conditions\n\n',sub='\n')

Graph_LinearTrend('Sh9HGL',from=as.chron("2004-01-01"), to=as.chron("2011-05-31"), data=tcd,ylab='HGL', ylim=ylim9, displayEqn=T,main='Shaft 9 HGL Historical Trends')
stripplot(Sh9HGL ~  fac | factor(Lines), data = tcd2[myFilter,], layout = c(5,1), jitter.data = TRUE, factor = 2.8, panel=panel.alarms, alarms=alarms9, ylim=ylim9, main='Shaft 9 HGL Alarm Points for Different Line Open Conditions\n\n',sub='\n')

dev.off()
