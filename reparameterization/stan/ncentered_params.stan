data{
  int N;
  int J;
  vector[N] y;
  vector[N] x;
  array[N] int groups;
}
parameters{
  real tau; // log of the standard deviation of the group intercepts
  real b; // slope
  real a_bar; // mean of the intercept distribution
  vector[J] z_j; // z scaled value for the group intercept
  real<lower=0> sigma; // error around the predicted value
}
transformed parameters{
  // calculate the intercepts from the z scores, standard deviation, and mean
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
