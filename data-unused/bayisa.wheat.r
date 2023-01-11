# bayisa.wheat.R
# Time-stamp: <11 Jan 2023 15:22:33 c:/drop/rpack/agridat/data-unused/bayisa.wheat.R>

# Reason not used: ?

# Source: Bayisa, D. (2010).
# Application of Spatial Mixed Model in Agricultural Field Experiment.
# Master thesis. Department of Statistics, Addis Ababa University.

# Electronic version from Johannes Forkman document
# "Exercise: Agricultural field experiment with spatial correlation"

# This thesis gives data for 1 uniformity experiment.
# A couple other experiments were also analyzed.
# Decided not to use.

library(asreml)
library(kw)
library(Hmisc)
library(lattice)
library(rio)

setwd("c:/drop/rpack/agridat/data-unused/")
dat0 <- import("bayisa.wheat.xlsx")

dat <- dat0

lib(desplot)
desplot(dat, yield~east+north, out1=rep, tick=TRUE)
str(dat)
describe(dat)

Solution in R (Agricultural field experiment with spatial correlation)
With fixed effects of varieties and random effects of blocks, the randomized complete block model can be fitted through

library(nlme)
library(multcomp)

dat <- transform(dat, gen=factor(gen), rep=factor(rep))

m1 <- lme(yield ~ gen,
          random = ~ 1 | rep, data = dat)
summary(m1)

summary(glht(m1, linfct = mcp(gen = "Tukey"))) # slow

According to the RCB analysis, variety 6 is top performing.

According to the Akaike information criterion (AIC), a model with exponential covariance gives a better fit: 

m2 <- lme(yield ~ gen,
          random = ~ 1 | rep, data = dat,
          corr = corExp(form = ~ east + north))
summary(m2)
anova(m2)

summary(glht(m2, linfct = mcp(gen = "Tukey")))

With this spatial model, the best variety is variety 1.
