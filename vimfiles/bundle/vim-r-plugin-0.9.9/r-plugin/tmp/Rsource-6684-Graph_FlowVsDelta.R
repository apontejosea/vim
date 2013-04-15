panel.custom	<-	function(x,y,...) {
	panel.abline(h=seq(-100,100,5),col='gray')
	panel.abline(v=seq(0,1000,50),col='gray')
	
	xl	<-	c(385,580,680,810)
	xr	<-	c(430,630,790,925)
	yt	<-	rep(25,length(xl))
	yb	<-	rep(-30,length(xl))
	panel.rect(xleft=xl,ybottom=yb,xright=xr, ytop=yt,col='light blue',alpha=.2)
	
	xPos	<-	(xr + xl)/2
	yPos	<-	rep(16,length(xl))
	txt		<-	c('2-Lines','3-Lines','4-Lines','6-Lines')
	panel.text(xPos,yPos,txt,fontface='bold')
	panel.xyplot(x,y,...)
}
