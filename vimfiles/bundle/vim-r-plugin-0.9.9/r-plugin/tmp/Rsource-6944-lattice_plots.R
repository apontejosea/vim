plt <- xyplot(mpg~wt|hp, scales=list(cex=.8, col="red"),
         panel=panel.smoother,
         xlab="Weight", ylab="Miles per Gallon",
         main="MGP vs Weight by Horse Power")
