data{
  int<lower=1> N; // number of observations
  vector[N] y; // observations
  vector[N] x; // predictors
}
parameters{
  real a; // intercept
  real b; // slope
  real<lower=0> sigma; // error
}
model{
  // priors
  a ~ normal(0, 1);
  b ~ normal(0, 1);
  sigma ~ exponential(1);
  
  // likelihood
  y ~ normal(a + b*x, sigma);
}
