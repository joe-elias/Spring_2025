data{
  int N; // number of observations
  vector[N] l_size; // vector of observations log(size)
  vector[N] age; // age at time of observation
  array[N] int observer; // who took the measurement
}
parameters{
  real l_y0; // log of size at time 0
  vector[4] b_obs; // coefficient of observer
  real<lower=0> rgr; // relative growth rate
  real<lower=0> sigma; // error term
}
model{
  // Prior
  l_y0 ~ normal(0, 1);
  b_obs ~ normal(0, 1);
  rgr ~ normal(0, 1);
  sigma ~ exponential(1);
  
  // likelihood
  l_size ~ normal(l_y0 + rgr*age + b_obs[observer], sigma);
}
