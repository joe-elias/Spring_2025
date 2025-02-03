

# Quick Review of Inferential Stats --------------------------------------------------


# let's start by constructing a sampling distribution of the mean for a normal population with
# mean 0 and standard deviation of 1 and an n 0f 10. Remember that the sampling distribution
# of the mean

# sample size
n <- 50

# number of replicate samples
n_samps <- 1000

# let's sample from this population 1000 times. We will store it in a matrix
# where each column is an independent sample
samples <- matrix(sample(rnorm(n*n_samps)), ncol = n_samps)

# now we will iterate over the columns and calculate the mean of each column (i.e.
# the mean of each independent sample)
mu <- apply(samples, 2, mean)

# plot the histogram of these values (i.e. an approximation of the sampling
# distribution of the mean)
hist(mu)

# the standard deviation of this distribution is the standard error of the mean,
# which we know analytically is sigma/sqrt(n), i.e. 1/sqrt(50) in this case. Is the standard
# deviation of this sampling distribution close to the analytic standard error?
1/sqrt(n)
sd(mu)

# we can use our understanding of sampling distributions and their dispersion
# to make inferences about the questions that we are interested in

# as an aside, this information is used to calculate p-values, to calculate
# a p-value of a one-sample t-test you would divide the mean of the sample by the
# standard error, this gives you an estimate of how many standard deviations the sample
# mean is from 0 given the null sampling distribution centered on 0. e.g.:

# take a sample
samp <- rnorm(n, 1, 1)

# calculate the t-value (number of sampling distribution stand. devs. the
# sample mean is away from 0)
t_val <- mean(samp)/(sd(samp)/sqrt(n))

# now calculate how extreme this value is (for a 2-tailed test we add the probability
# above and below the t_value and -t_value)
pt(t_val, n-1, lower.tail = F) + pt(-t_val, n-1)

t.test(samp)

# Confidence Intervals ----------------------------------------------------



# Let's reacquaint ourselves with our old friend the confidence interval
# remember that a 95% confidence interval is expected to contain the true value
# 95% of the time. But this doesn't mean there is 95% probability that a given
# confidence interval contains the true value, it either does or it doesn't.

# let's try sampling from a normal distribution with a mean of 0, a sd of 1
# and a sample size of 10. Let's repeat this sampling 100 times and see how often 
# our confidence interval contains the true population mean of 0

n_samps <- 100

# sample it into a matrix to perform calculations on
samps <- matrix(rnorm(n*n_samps), ncol = n_samps)

# get the means of the replicate samples
mu_samps <- apply(samps, 2, mean)

# get standard error estimates (remember, standard errors are standard deviations of 
# sampling distributions--fu***ng statisticians)
se_samps <- apply(samps, 2, function(x) sd(x)/sqrt(n))

# the sampling distribution for the mean of a normal distribution with unknown
# mean and unknown standard deviation follows the t distribution with 
# n-1 degrees of freedom, so, to convert our means and standard 
# errors into 95% confidence intervals we take the .025th
# and .975th quantiles of an n-1 t distribution, multiply that by our standard 
# error estimate,and add it to the sample mean.

# So our confidence intervals are...
lwr <- mu_samps + qt(.025, n-1) * se_samps
upr <- mu_samps + qt(.975, n-1) * se_samps

## plot our 100 confidence intervals

# index for the intervals
id <- 1:100

# whether an interval contains the true value (0) + 1 to index color to make intervals
# that miss the true value red, and intervals that contain it 0
in_out <- as.integer(upr >= 0 & lwr <= 0) + 1
in_out_cols <- c("red", "black")[in_out]

# create an empty plot to put the intervals in
plot(NULL, xlim = c(1,100), ylim = c(min(lwr), max(upr)), ylab = "Mean")

# plot the intervals, make those that contain the true value black and those
# that don't red
segments(x0 = id, y0 = lwr, x1 = id, y1 = upr, col = in_out_cols)

# add a horizontal line to indicate the true value of the population
abline(h = 0, col = "grey")

# how many intervals missed the true value?
sum(upr >= 0 & lwr <= 0)


# so the confidence interval is a way for us to make inferences about our data.
# if we want to ask if a population's mean is different than 0, we sample, construct
# the confidence interval (at whatever confidence, for an alpha of .05, we would use
# a 95% confidence interval), and see if our interval contains that value or not. If 
# our interval contains 0, we wouldn't reject the null hypothesis that the population's
# mean is 0, otherwise, we could.



# The Bootstrap -----------------------------------------------------------



# So to bring it back around to bootstrapping: bootstrapping is a method that allows
# us to create sampling distributions--and confidence intervals--for any statistic
# that we can think of. For example, we (humanity, not just hacky hours) don't know
# how to analytically construct a sampling distribution for the median, but with
# bootstrapping it is straightforward.

# the big assumption for using bootstrapping is that the sample accurately represents
# the population. If this is true, we can approximate the sampling distribution of 
# any statistic of interest by re-sampling, with replacement, from our sample. We then
# calculate our statistic and repeat this process many times. This will give us
# an approximation of the sampling distribution and the simplest way to get a confidence
# interval is to take the .025 and .925 quantile values (for a 95% confidence interval)

n <- 50

# we take our sample
m <- rnorm(n)

# we take b re-samples with replacement
b <- 1000
B <- matrix(sample(m, n*b, replace = T), ncol = b)

# and calculate the median for each bootstrap sample

meds <- apply(B, 2, median)

# and our 95% confidence interval is...
quantile(meds, c(.025, .975))

# we can plot it:
hist(meds)
abline(v = quantile(meds, c(.025, .975)), col = "red")


# benefits of bootstrapping: flexible, maybe more realistic assumptions
# drawbacks: need to assume that the sample is representative of the population,
# i.e. a bad sample will give a bad confidence interval.

# try it out, take a sample from a population with two groups having some characteristic
# poisson distributed around the group mean. Group A has a mean of 2 and group B has
# a mean of 4. Sample 30 individuals from each group and use bootstrapping to 
# construct a 95% confidence interval of the difference in means between the groups (
# i.e. what is the confidence interval of mu_b - mu_a). Does the interval contain 0?
# does it contain the true value of 2?


n <- 30

# sample A
a <- rpois(n, 2)

# sample B
b <- rpois(n, 4)

# take 1000 bootstrap replicates of a and b, calculate the difference of the means
a <- matrix(sample(a, n*1000, replace = T), ncol = 1000)
b <- matrix(sample(b, n*1000, replace = T), ncol = 1000)

# what is the 95% confidence interval
diffs <- apply(b, 2, mean) - apply(a, 2, mean)
quantile(diffs, c(.025, .975))

# plot the sampling distribution of the difference of means
hist(diffs)
abline(v = quantile(diffs, c(.025, .975)), col = "red", lwd = 2)


# let's try with a correlation, with a true correlation of .7
set.seed(12042014)
SIGMA <- matrix(c(1, .7, .7, 1), ncol = 2)
y <- MASS::mvrnorm(n, mu = c(0,0), Sigma = SIGMA)

# here's the analytic estimates of the confidence interval
cor.test(y[,1], y[,2])$conf.int


# this time, it's important to keep track of indices since a and b are not independent!
idx <- matrix(sample(1:nrow(y), n*10000, replace = T), ncol = 10000)

# calculate the correlation of each bootstrap
cor_boots <- apply(idx, 2, function(x) cor(y[x,1], y[x,2]))

# what is the 95% confidence interval?
quantile(cor_boots, c(.025, .975))

hist(cor_boots)
abline(v = .7, col = "white", lwd = 5)
abline(v = .7, col = "red", lwd = 2)
