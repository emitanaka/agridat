# rayner.hay.R

# Reason not used:
# The data in this experiment are extremely variable with no obvious
# treatment or spatial pattern.

# Source: Rayner. A First Course In Biometry For Agriculture Students
# Chap 21, page 515.


library(asreml)
library(dplyr)
library(kw)
library(Hmisc)
library(lattice)
library(rio)

setwd("c:/x/rpack/agridat/data-unused/")
lib(dplyr)
lib(tibble)
dat0 <- import("rayner.hay.xlsx", readxl=TRUE)
dat0
lib(readxl)

dat <- read_excel("rayner.hay.xlsx")
dat

if(require(desplot)){
  desplot(yield ~ col*row, dat,
          main="rayner.hay", flip=TRUE, out1=rep,
          aspect=(6*12.5)/(8*20))
}
