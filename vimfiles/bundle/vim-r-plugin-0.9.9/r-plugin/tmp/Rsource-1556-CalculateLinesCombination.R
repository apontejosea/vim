CalculateLinesCombination <- function(flows, threshold=50) {
  
  linesComb			<-	rep('', nrow(flows))
  
  for(i in 1:ncol(flows))  {
		ind				<-	which(is.na(flows[,i]))
		if(length(ind)>0)  {
			flows[ind,i]	<-	0
		}	
	
		test			  <-	flows[,i] < threshold
		tempVec			<-	ifelse(test, '', colnames(flows)[i])
		linesComb		<-	paste(linesComb, tempVec, sep='')
	}
  
	# Boolean vectors used for checking for errors in categorization (detection of outliers)
	isE1Present		<-	grepl('E1', linesComb)
	isE2Present		<-	grepl('E2', linesComb)
	isE3Present		<-	grepl('E3', linesComb)
	isW1Present		<-	grepl('W1', linesComb)
	isW2Present		<-	grepl('W2', linesComb)
	isW3Present		<-	grepl('W3', linesComb)

	# Error if one of the large lines are open and the other one is not
	largeLinesError	<-	(!isE3Present & isW3Present) | (isE3Present & !isW3Present)
	# Error if any of the large lines are open without all the small lines open
	sequenceError	  <-	(isE3Present | isW3Present) & !(isE1Present & isW1Present & isE2Present & isW2Present)
	  
	# Change those erroneous line combinations to an empty string ""
	linesComb[largeLinesError]	<-	NA
	linesComb[sequenceError]	  <-	NA
	
	return(linesComb)
}
