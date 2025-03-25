library(cmdstanr)
library(bayesplot)



# Bernoulli ---------------------------------------------------------------

n <- 100
p <- rbeta(1,2,2)
y <- rbinom(n, 1, p)




# Estimating the mean and standard deviation ------------------------------


mu <- rnorm(1, 0, 5)
sigma <- rexp(1)

y <- rnorm(n, mu, sigma)




# multiple intercepts model ----------------------------

group <- rep(1:4, each = 25)

mu <- rnorm(4, 0, 5)
sigma <- rexp(1, 1/10)

y <- rnorm(n, mu[group], sigma)




# Linear Regression -------------------------------------------------------

a <- rnorm(1)
b <- rnorm(1)
sigma <- exponential(1)
x <- rnorm(n)
y <- rnorm(n, a + b*x, sigma)



# Logistic Regression -----------------------------------------------------

a <- rnorm(1, 0, .25)
b <- rnorm(1, 0, .5)
x <- rnorm(n)
y <- rbinom(n, 1, plogis(a + b*x))







