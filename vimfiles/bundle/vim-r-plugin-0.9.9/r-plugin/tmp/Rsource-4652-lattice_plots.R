plt <- xyplot(mpg~wt|hp, data=mtcars, 
         panel=panel.smoother,
         xlab="Weight", ylab="Miles per Gallon",
         main="MPG vs Weight by Horse Power")
print(plt)

