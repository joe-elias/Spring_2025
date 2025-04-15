data{
  int N; // number of observations
  int J; // number of groups
  vector[N] y; // observations
  array[N] int group;
}
parameters{
  vector[J] mu; // means of the groups
  real<lower=0> sigma; // error
}
model{
  // priors
  mu ~ normal(0, 5);
  sigma ~ exponential(.1);
  
  // likelihood
  y ~ normal(mu[group], sigma);
}
