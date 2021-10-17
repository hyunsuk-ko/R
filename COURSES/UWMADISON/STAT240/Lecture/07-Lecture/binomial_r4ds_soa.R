knitr::opts_chunk$set(echo=TRUE,message=FALSE,warning=FALSE,cache=TRUE,autodep=TRUE,cache.comments=FALSE)
library(tidyverse)
library(lubridate)
## Note: this code assumes viridis.R is two steps up the file directory tree in a `scripts` folder
source("../../scripts/viridis.R")

'''
<rbinom>
- first param: num of values to generate
'''
rbinom(n=5, size=20, prob=0.4)
rbinom(5, 20, 0.4)

'''
<dbinom>
- measures the density
'''
round(dbinom(0:20, 20, 0.4), 6)
dbinom(8, 20, 0.4)

'''
<pbinom>
- calculates the sum of the probabilities up to the value.
'''
pbinom(6, 20, 0.4) # prob(X <= 6)
sum(dbinom(0:6, 20, 0.4))

'''
<qbinom>
- takes cumulative distribution function(cdf).
'''
# P(X <= 8) = 0.5956
# P(X <= 7) = 0.4159
qbinom(0.5, 20, 0.4)
qbinom(seq(0.1, 0.9, 0.1), 20, 0.4)

'''
<Graphing Binomial Distributions>
'''
gbinom <- function(n,p,scale=FALSE,
                   a=ifelse(scale,floor(n*p-4*sqrt(n*p*(1-p))),0),
                   b=ifelse(scale,ceiling(n*p+4*sqrt(n*p*(1-p))),n),
                   main=NULL,...) {
  # make sure a and b are integers
  a <- round(a)
  b <- round(b)
  # make sure a < b
  if(a > b) {
    temp = a
    a = b
    b = temp
  }
  # make sure a and b are in range
  if(a < 0) a = 0
  if(b > n) b = n
  # create the sequence of possible values to graph
  x <- seq(a,b)
  # compute the probabilities to graph
  probability <- dbinom(x,n,p)
  # Choose a title for the plot if one is not passed
  if(is.null(main)){
    main <- paste("Binomial(",n,",",p,")")
  }
  
  # save the graph as an object which can be returned
  graph <- ggplot(data.frame(x,probability),aes(x=x,y=probability,xend=x,yend=0),...) +
    geom_segment(...) +
    xlab('x') +
    ylab('Probability') +
    geom_hline(yintercept=0) +
    ggtitle(main)
  graph
  # return the graph object, but do so invisibly so no output is shown on the screen
  # return(invisible(graph))
}
gbinom(90, 0.5)
gbinom(90, 0.5, scale=TRUE)
# modifies the range of possible x values displayed.

gbinom(90, 0.5, a=60, b=65, color="firebrick")
# can have better control over the range of values plotted using arguments a & b (endpoints of inerval).

gbinom(90, 0.5, scale = TRUE, color = "gray") +
  geom_binom_density(90, 0.5, a = 50, scale = TRUE, color = "firebrick") +
  ggtitle(paste0("P(X >= 50) = ", round(1 - pbinom(49,90,0.5),4))) +
  theme_bw()
