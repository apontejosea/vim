married <- c("Yes","Yes","No","No","Yes","","No","Yes")

character.to.binary <- function(x){
  switch(x,
    Yes = 1,
    No  = 0,
    NA)
}

binary.married <- sapply(married, character.to.binary)
