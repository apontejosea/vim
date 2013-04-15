library(grid)

stickperson <- function() {
  grid.circle(x=.5, y=.8, r=.1, gp=gpar(fill="yellow"))
  grid.lines(c(.5,.5), c(.7,.2)) # vertical line for body
  grid.lines(c(.5,.7), c(.6,.7)) # right arm
  grid.lines(c(.5,.3), c(.6,.7)) # left arm
  grid.lines(c(.5,.65), c(.2,0)) # right leg
  grid.lines(c(.5,.35), c(.2,0)) # left leg
}

pushViewport(viewport())
  grid.lines(c(.05, .95), c(.95, .05))
  grid.lines(c(.05, .95), c(.05, .95))
  for (i in 1:50) {
  vp <- viewport(h=.9, w=.9)
  pushViewport(vp)
  grid.rect()
}

upViewport(50)

for (i in 1:30) {
  vp <- viewport(h=.9, w=.9)
  pushViewport(vp)
  # person 1:
  if(i == 5) {
    pushViewport(viewport(x=.8))
    stickperson()
    upViewport()
  }
  # person 2:
  if(i == 20) {
    pushViewport(viewport(x=.2))
    stickperson()
    upViewport()
  }
  # person 3:
  if(i == 30) stickperson()
}


