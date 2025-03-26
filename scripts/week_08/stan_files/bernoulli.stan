data{
  int N; // number of observations
  array[N] int y; // data
  array[N] int sex;
}
parameters{
  vector<lower=0,upper=1>[2] p; // probability that an anole dives
}
model{
  // priors
  p ~ beta(2,2); // prior for p
  
  // likelihood
  y ~ bernoulli(p[sex]);
}
generated quantities{
  real diff = p[1] - p[2];
}
