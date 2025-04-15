# load everything in

install.packages("piecewiseSEM")
install.packages("glmmTMB")
install.packages("multcompView")

library(piecewiseSEM)
library(glmmTMB)
library(multcompView)

# intro example showing why path analysis can be useful/important for highly interconnected systems

c = rnorm(200)

b = rnorm(200, c, 1)

a = rnorm(200, b + c, 1)

dat<-data.frame(a,b,c)

amod <- lm(a ~ b + c, data = dat)
summary(amod)

bmod <- lm(b ~ c, data = dat)

model <- psem(amod, bmod)
summary(model)


# zero inflation example
hist(rpois(1e4, 5))

fake_0 = rbinom(1e4, 1, .7)

hist(fake_0*rpois(1e4, 5))


# time for my data yippee

tree_totals <- read.csv("tree_totals.csv")


# VAL path analysis code


# link log is different than log transforming the raw data: "The transformation changes the raw data. 
# The link function doesn’t touch the raw data, instead you can think of it as a transformation of the model for the mean 
# of the raw data. https://www.r-bloggers.com/2018/10/generalized-linear-models-understanding-the-link-function/

# logistic regression uses logit link but since gamma is 0-inf we use log link instead

# using glmmTMB because it allows zero inflation 
# Include random effect: glmmTMB is a mixed model function so it requires
# at least one random effect with the fixed effects
