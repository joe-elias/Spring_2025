data{
  int N;
  int J;
  vector[N] y;
  vector[N] x;
  array[N] int groups;
}
parameters{
  real tau;
  real b;
  real a_bar;
  vector[J] z_j;
  real<lower=0> sigma;
}
transformed parameters{
  vector[J] a_j = z_j * exp(tau) + a_bar;
}
model{
  // hyper-priors for the intercept
  tau ~ normal(0, 3);
  a_bar ~ normal(0, 1);
  
  // priors
  z_j ~ normal(0, 1);
  b ~ normal(0, 1);
  sigma ~ exponential(.5);
  
  // likelihood
  y ~ normal(a_j[groups] + b*x, sigma);
}
