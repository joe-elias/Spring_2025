library(cmdstanr)
library(bayesplot)
library(tidyverse)

# compile model (basic regression model)
mod1 <- cmdstan_model("scripts/week_09/basic.stan")

# read in data
d <- read.csv("data/week_09/hacky.csv")

# prep data for stan
dat1 <- list(
  N = nrow(d),
  l_size = d$l_size,
  age = d$age,
  observer = d$observer
)

# fit the model to the data
fit1 <- mod1$sample(
  data = dat1,
  chains = 4,
  parallel_chains = 4
)

mcmc_intervals(fit1$draws("b_obs"))



# varying intercepts model ------------------------------------------------

mod2 <- cmdstan_model("scripts/week_09/var_int.stan")


# prep data for stan
dat2 <- list(
  N = nrow(d),
  l_size = d$l_size,
  age = d$age,
  observer = d$observer,
  id = d$id
)

fit2 <- mod2$sample(
  data = dat2,
  chains = 4,
  parallel_chains = 4
)

mcmc_intervals(fit2$draws("y0_i"))




# model for seed size -----------------------------------------------------

mod3 <- cmdstan_model("scripts/week_09/int_mod.stan")

dat3 <- list(
  N = nrow(d),
  l_size = d$l_size,
  age = d$age,
  observer = d$observer,
  id = d$id,
  seed_size = d$seed_size_std
)

fit3 <- mod3$sample(
  data = dat3,
  chains = 4,
  parallel_chains = 4
)

mcmc_intervals(fit3$draws("b_seed"))


