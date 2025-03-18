
# Broman's Socks ----------------------------------------------------------

# here is a function to simulate picking 11 socks from the dryer and seeing
# how many have pairs and how many are odds
pick_11_socks <- function(n_socks, prop_pairs){
  n_pairs <- round(floor(n_socks / 2) * prop_pairs)
  n_odd <- n_socks - n_pairs * 2
  
  # Simulating picking out n_picked socks
  socks <- rep(seq_len(n_pairs + n_odd), rep(c(2, 1), c(n_pairs, n_odd)))
  picked_socks <- sample(socks, size =  min(n_picked, n_socks))
  sock_counts <- table(picked_socks)
  
  # Returning the parameters and counts of the number of matched 
  # and unique socks among those that were picked out.
  c(unique = sum(sock_counts == 1), pairs = sum(sock_counts == 2),
    n_socks = n_socks, n_pairs = n_pairs, n_odd = n_odd, prop_pairs = prop_pairs)
}

# play around to get the priors for the number of socks and the proportion of
# socks that have pairs



# now simulate picking 11 socks using parameters from the priors:

n_picked <- 11 # The number of socks to pick out of the laundry

sock_sim <- replicate(100000, {
  # Generating a sample of the parameters from the priors
  prior_mu <- # enter prior here
  prior_sd <- # enter prior here
  prior_size <- prior_mu^2 / (prior_sd^2 - prior_mu)
  n_socks <- rnbinom(1, mu = prior_mu, size = prior_size)
  prop_pairs <- rbeta(1, shape1 = "enter prior here", shape2 = "enter prior here")
  pick_11_socks(n_socks, prop_pairs)
})
sock_sim <- t(sock_sim)


# keep only the simulations that produced 11 unpaired socks


# evaluate the posterior



# MCMC with Metropolis-Hastings -------------------------------------------

# let's simulate a linear model

n <- 200
a <- .5
b <- 1.5
sigma <- 1.8
x <- rnorm(n)
y <- rnorm(n, a + b*x, sigma)
plot(y ~ x)
abline(a = a, b = b)


# play around to see what priors work well


# here is the code to run the MH algorithm (may need to adjust the priors depending on
# what we decided above)

a_post <- b_post <- sig_post <- c()
a_post[1] <- rnorm(1)
b_post[1] <- rnorm(1)
sig_post[1] <- rexp(1)
a_accept <- b_accept <- sig_accept <- 0

for(i in 1:1e5){
  # draw a proposal for a
  a_ast <- rnorm(1, a_post[i], .1)
  # calculate prob of keeping a_ast
  r <- exp((sum(dnorm(y, a_ast + b_post[i]*x, sig_post[i], log = T))+
            dnorm(a_ast,0, 1, log = T)) -
          (sum(dnorm(y, a_post[i] + b_post[i]*x, sig_post[i], log = T))+
            dnorm(a_post[i],0,1,log = T)))
  # decide to keep the proposal or previous value
  a_post[i+1] <- ifelse(runif(1) < r, a_ast, a_post[i])
  if(a_post[i+1]!=a_post[i]) a_accept <- a_accept + 1
  # draw a proposal for b
  b_ast <- rnorm(1, b_post[i], .1)
  # calculate the probability of keeping b_ast
  r <- exp((sum(dnorm(y, a_post[i+1] + b_ast*x, sig_post[i], log = T))+
            dnorm(b_ast,0, 1, log = T)) -
          (sum(dnorm(y, a_post[i+1] + b_post[i]*x, sig_post[i], log = T))+
            dnorm(b_post[i],0,1,log = T)))
  # decide whether to keep b_ast or the previous value
  b_post[i+1] <- ifelse(runif(1) < r, b_ast, b_post[i])
  if(b_post[i+1]!=b_post[i]) b_accept <- b_accept + 1
  # draw a proposal for sigma
  sig_ast <- rgamma(1, sig_post[i]^2/.003, sig_post[i]/.003)
  # calculate prob of keeping sig_ast (need to adjust for asymmetry of proposal in the next step)
  r <- (sum(dnorm(y, a_post[i+1] + b_post[i+1]*x, sig_ast, log = T))+
              dexp(sig_ast, 1, log = T)) -
            (sum(dnorm(y, a_post[i+1] + b_post[i+1]*x, sig_post[i], log = T))+
              dexp(sig_post[i], 1, log = T))
  # adjust for asymmetry of proposal
  q <- dgamma(sig_post[i], sig_ast^2/.003, sig_ast/.003, log = T) -
            dgamma(sig_ast, sig_post[i]^2/.003, sig_post[i]/.003, log = T)
  r <- exp(r + q)
  # decide whether to keep proposal
  sig_post[i+1] <- ifelse(runif(1) < r, sig_ast, sig_post[i])
  if(sig_post[i+1]!=sig_post[i]) sig_accept <- sig_accept + 1
  if(i%%5000==0) print(paste0("Iteration ", i, " complete!"))
}



# check the chains

# evaluate the posterior



