# crossa.87evt13.R

# Reason not used: This is not the original rep-level data, but means.

# Source: Crossa 1997
# Sites Regression and Shifted Multiplicative Model Clustering

# Site codes are listed in Crossa et al 1993,
# A shifted multiplicative model cluster analysis for grouping envts

# The data in the Excel file are the site means.
# Crossa used the rep-level data (4 reps per site).
# Decided not to use.

libs(gge,lattice,rio)

setwd("c:/x/rpack/agridat/data-unused/")
mat <- import("crossa.87evt13.csv")

library(reshape2)
dat <- melt(mat, id.var=c('group','site'))
names(dat)[3:4] <- c('gen','yield')

library(agridat)
biplot(gge(yield~gen*site,dat))

m2 <- mat[,-c(1:2)]
rownames(m2) <- mat$site
m2 <- as.matrix(m2)
heatmap(as.matrix(t(m2)), scale="col")
cl2 <- twclust(m2)
plot(cl2)

dat$site <- factor(dat$site)
m1 <- lm(yield ~ gen + site, data=dat)
anova(m1)
