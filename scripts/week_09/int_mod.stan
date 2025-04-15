data{
  int N; // number of observations
  vector[N] l_size; // vector of observations log(size)
  vector[N] age; // age at time of observation
  array[N] int observer; // who took the measurement
  array[N] int id; // ids of individuals
  vector[N] seed_size;
}
parameters{
  real l_y0; // mean log size at time 0 of all individuals
  real b_seed; // relationship between seed size and y0
  real<lower=0> sig_y0; // st. dev of y0
  vector[100] y0_i; // each indivual intercept
  vector[4] b_obs; // coefficient of observer
  real<lower=0> rgr; // relative growth rate
  real<lower=0> sigma; // error term
}
model{
  // hyperpriors
  l_y0 ~ normal(0, 1);
  sig_y0 ~ exponential(1);
  b_seed ~ normal(0, 1);
  
  // Prior
  y0_i ~ normal(0, sig_y0);
  b_obs ~ normal(0, 1);
  rgr ~ normal(0, 1);
  sigma ~ exponential(1);
  
  
  // predicting intercept
  vector[N] y0;
  for(i in 1:N){
    y0[i] =  l_y0 + b_seed*seed_size[i] + y0_i[id[i]];
  }
  
  
  
  // likelihood
  l_size ~ normal(y0 + rgr*age + b_obs[observer], sigma);
}
