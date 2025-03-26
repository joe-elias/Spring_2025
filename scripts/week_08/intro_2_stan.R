library(cmdstanr)
library(bayesplot)



# Bernoulli ---------------------------------------------------------------
n <- 100
p <- rbeta(1,2,2)
y <- rbinom(n, 1, p)

hist(rbeta(1e4, 2, 2))


dat <- list(
  N = n,
  y = y
)

mod_bern <- cmdstan_model("scripts/week_08/stan_files/bernoulli.stan")

fit_bern <- mod_bern$sample(
  data = dat,
  chains = 4,
  parallel_chains = 4
)

fit_bern$diagnostic_summary()

fit_bern$print()

mcmc_trace(fit_bern$draws("p"))

mcmc_intervals(fit_bern$draws("p"))

p <- fit_bern$draws("p", format = "df")$p

sum(p>.2)/length(p)

n <- 100
p <- rbeta(2,2,2)
sex <- rep(c(1,2), each = 50)
y <- rbinom(n, 1, p[sex])


mod_bern_sex <- cmdstan_model("scripts/week_08/stan_files/bernoulli.stan")

dat <- list(
  N = n,
  y = y,
  sex = sex
)

fit_bern_sex <- mod_bern_sex$sample(
  data = dat,
  chains = 4,
  parallel_chains = 4
)

fit_bern_sex$diagnostic_summary()

fit_bern_sex$print()

mcmc_trace(fit_bern_sex$draws("p"))

mcmc_intervals(fit_bern_sex$draws(c("p","diff")))




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
sigma <- rexp(1)
x <- rnorm(n)
y <- rnorm(n, a + b*x, sigma)

hist(rexp(1e4, 1))

linear_mod <- cmdstan_model("scripts/week_08/stan_files/linear_regression.stan")

dat <- list(
  N = n,
  x = x,
  y = y
)

linear_fit <- linear_mod$sample(
  data = dat,
  chains = 4,
  parallel_chains = 4
)

linear_fit$diagnostic_summary()


linear_fit$print()

mcmc_intervals(linear_fit$draws(c("a", "b")))
mcmc_intervals(linear_fit$draws("sigma"))





# Logistic Regression -----------------------------------------------------

a <- rnorm(1, 0, .25)
b <- rnorm(1, 0, .5)
x <- rnorm(n)
y <- rbinom(n, 1, plogis(a + b*x))







