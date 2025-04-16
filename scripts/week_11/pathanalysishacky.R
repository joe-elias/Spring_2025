# load everything in
# install these packages if you don't have them
# install.packages("piecewiseSEM")
# install.packages("glmmTMB")
# install.packages("multcompView")

library(piecewiseSEM)
library(glmmTMB)
library(multcompView)

# intro example showing why path analysis can be useful/important for highly interconnected systems

# example system where a <- b <- c -> a
n <- 1000

# simulate c, independent of everything
c <- rnorm(n) 

# simulate b, conditional on c
b <- rnorm(n, c, 1)

#simulate a conditional on b and c
a <- rnorm(n, b + c, 1)

# make a data frame
dat<-data.frame(a,b,c)

# model a as a function of b and c
amod <- lm(a ~ b + c, data = dat)

# notice it has the correct coefficient for b, but only
# part (the direct effect) of c
summary(amod)

# let's try predicting a as a function of c
cmod <- lm(a ~ c, data = dat)

# it get's close to the true total effect of c (2)
summary(cmod)


# let's try just predicting a from b
abmod <- lm(a ~ b, data = dat)

# it very confidently get's the wrong value for b
summary(abmod)


# so in this system we can't get the correct values for b and c simultaneously
# using regression alone, but we can use path analysis to get there

# first we need to have a model for b
bmod <- lm(b ~ c, data = dat)

# then we add our models for a and b together in a path analysis
model <- psem(amod, bmod)
summary(model)





# zero inflation example
hist(rpois(1e4, 5))

fake_0 = rbinom(1e4, 1, .7)

hist(fake_0*rpois(1e4, 5))


# time for my data yippee

tree_totals <- read.csv("data/week_11/tree_totals.csv")


# VAL path analysis code


# link log is different than log transforming the raw data: "The transformation changes the raw data. 
# The link function doesn’t touch the raw data, instead you can think of it as a transformation of the model for the mean 
# of the raw data. https://www.r-bloggers.com/2018/10/generalized-linear-models-understanding-the-link-function/

# logistic regression uses logit link but since gamma is 0-inf we use log link instead

# using glmmTMB because it allows zero inflation 
# Include random effect: glmmTMB is a mixed model function so it requires
# at least one random effect with the fixed effects




val1 <- glmmTMB(ara2 ~ (1|census) + tree_species, data = tree_totals,
                family = Gamma(link = "log"), ziformula = ~1)

val2 <- glmmTMB(lep2 ~ ara2 + lep_shelters2 + (1|census) + tree_species,
                data = tree_totals, family = Gamma(link = "log"),
                ziformula = ~1)

val3 <- glmmTMB(lep_shelters2 ~ ara2 + (1|census) + tree_species,
                data = tree_totals,
                family = Gamma(link = "log"),
                ziformula = ~1)

val4 <- glmmTMB(gall2 ~ (1|census) + tree_species,
                data = tree_totals, family = Gamma(link = "log"), 
                ziformula = ~1)

val <- psem(val1, val2, val3, val4)

summary(val, conserve = T)

# force lep_shelters and gall2 to be uncorrelated
val <- psem(val1, val2, val3, val4,
            lep_shelters %~~% gall2)

summary(val, conserve = T)

