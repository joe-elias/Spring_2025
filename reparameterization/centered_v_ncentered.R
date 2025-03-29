library(cmdstanr)
library(bayesplot)

# let's work through a common pathological posterior when working
# with hierarchical models let's play around with a varying
# intercepts model (treating the intercept as a "random effect" if
# that nomenclature helps anchor you)

# Here's the model:

# y_i ~ normal(a[j_i] + b*x_i, sigma)
# a[j] ~ normal(a_bar, exp(tau))
# a_bar ~ normal(0, 1)
# tau ~ normal(0, 3)
# b ~ normal(0, 1)
# sigma ~ exponential(1)

# set seed so the output is always the same
set.seed(120414)


# number of observations
n <- 50
# number of groups 
j <- 1:10

# simulate the data
x <- rnorm(n)
a_bar <- rnorm(1, 0, 1)
tau <- rnorm(1, 0, 3)
a_j <- rnorm(10, a_bar, exp(tau))
b <- rnorm(1)
sigma <- rexp(1, .5)
groups <- sample(j, n, replace = T)
y <- rnorm(n, a_j[groups] + b*x, sigma)

# read in and fit the centered model
mod_c <- cmdstan_model("reparameterization/stan/centered_params.stan")

dat <- list(
  N = n,
  J = length(j),
  y = y,
  x = x,
  groups = groups
)

fit_c <- mod_c$sample(
  data = dat,
  chains = 4,
  parallel_chains = 4,
  refresh = 1000
)

# so we have 37 divergent transitions, immediately we know we 
# can't trust this output, let's look at rhat and ess:

fit_c$print()

# ess for tau is too low, but rhat looks good, so this is just a 
# warning about blindly trusting rhat

# let's look at a parcoord plot, and extract the nuts
# parameters so that we can highlight the divergent samples (in red) in
# our plots

np_cp <- nuts_params(fit_c)
mcmc_parcoord(fit_c$draws(c("a_j", "tau")), np = np_cp)

# we see the divergent transitions happen when tau is small, this is 
# because there is a funnel shape to the posterior, let's look at this by
# plotting tau and a_j[5]


mcmc_scatter(fit_c$draws(c("a_j[5]", "tau")), np = np_cp)

# you can see the funnel shape and that the divergences are mostly toward the
# neck of the funnel. The sampler has a hard time getting into the neck
# to  properly sample the posterior. We need to transform
# this into a space that is easier for the sampler to move around. (conceptually
# think of this as a skateboarder having an easier time skating in a bowl
# shape skate park than a funnel shaped one!) The 
# model above uses what is called the "centered parameterization" we need
# to use the "non-centered parameterization to do this understand that the
# centered parameterization:

# a_j ~ normal(a_bar, exp(tau))

# is mathematically the same as the non-centered parameterization (if this
# looks similar to a z-score to you--you are on the right track!):

# z_j ~ normal(0, 1)
# a_j = z_j * exp(tau) + a_bar

# but the sample has a much easier time sampling z_j (bowl shaped skate park)
# than a_j (funnel of death skate park). Compare 
# "stan/centered_params.stan" with "stan/ncentered_params.stan"
# we now sample z_j from a standard normal and then calculate a_j from that!
# we do this in the transformed parameters block

# let's try fitting our non-centered model
mod_nc <- cmdstan_model("reparameterization/stan/ncentered_params.stan")

fit_nc <- mod_nc$sample(
  data = dat,
  chains = 4,
  parallel_chains = 4
)

fit_nc$diagnostic_summary()

# no divergences!

fit_nc$print()

# rhat and ess looking better now, let's compare the scatterplots 
# of tau and a_j[5] from the 2 models

mcmc_scatter(fit_c$draws(c("a_j[5]", "tau")))
mcmc_scatter(fit_nc$draws(c("a_j[5]", "tau")))

# see how much deeper into the funnel the non-centered model samples
# compared to centered (-4ish vs -9ish). All that space is consistent
# with the model and the data, but we would have missed it with
# less sensitive samplers!