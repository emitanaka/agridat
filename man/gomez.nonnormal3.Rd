\name{gomez.nonnormal3}
\alias{gomez.nonnormal3}
\docType{data}
\title{
  RCB experiment of rice, 12 varieties with leafhopper survival
}
\description{
  RCB experiment of rice, 12 varieties with leafhopper survival
}
\usage{data("gomez.nonnormal3")}
\format{
  A data frame with 36 observations on the following 3 variables.
  \describe{
    \item{\code{gen}}{genotype/variety of rice}
    \item{\code{rep}}{replicate}
    \item{\code{hoppers}}{percentage of surviving leafhoppers}
  }
}
\details{
  For each rice variety, 75 leafhoppers were caged and the percentage of
  surviving insects was determined.

  Gomez suggest replacing 0 values by 1/(4*75) and replacing 100 by
  1-1/(4*75) where 75 is the number of insects.

  In effect, this means, for example, that (1/4)th of an insect survived.

  Because the data are percents, Gomez suggested using the arcsin
  transformation.

  Used with permission of Kwanchai Gomez.

}
\source{
  Gomez, K.A. and Gomez, A.A.. 1984,
  Statistical Procedures for Agricultural Research.
  Wiley-Interscience.
  Page 307.
}
\references{
  None.
}
\examples{

library(agridat)
data(gomez.nonnormal3)
dat <- gomez.nonnormal3

# First, replace 0, 100 values
dat$thoppers <- dat$hoppers
dat <- transform(dat, thoppers=ifelse(thoppers==0, 1/(4*75), thoppers))
dat <- transform(dat, thoppers=ifelse(thoppers==100, 100-1/(4*75), thoppers))
# Arcsin transformation of percentage p converted to degrees
# is arcsin(sqrt(p))/(pi/2)*90
dat <- transform(dat, thoppers=asin(sqrt(thoppers/100))/(pi/2)*90)

# QQ plots for raw/transformed data
libs(reshape2, lattice)
qqmath( ~ value|variable, data=melt(dat),
       main="gomez.nonnormal3 - raw/transformed QQ plot",
       scales=list(relation="free"))

m1 <- lm(thoppers ~ gen, data=dat)
anova(m1) # Match Gomez table 7.25
## Response: thoppers
##           Df  Sum Sq Mean Sq F value    Pr(>F)
## gen       11 16838.7 1530.79  16.502 1.316e-08 ***
## Residuals 24  2226.4   92.77

}
\keyword{datasets}
