data{
  int N; // number of observations
  array[N] int y; // 0,1 observations
  vector[N] x;
}
parameters{
  real alpha; // intercept in the log-odds
  real beta; // slope of log-odds
}
model{
  // priors
  alpha ~ normal(0, 1);
  beta ~ normal(0, 1);
  
  
  // likelihood
  y ~ bernoulli_logit(alpha + beta*x);
}
