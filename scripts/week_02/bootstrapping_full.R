

# Quick Review of Inferential Stats --------------------------------------------------


# let's start by constructing a sampling distribution of the mean for a normal population with
# mean 0 and standard deviation of 1 and an n of 10. Remember that the sampling distribution
# of the mean

# sample size
n <- 10

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
# which we know analytically is sigma/sqrt(n), i.e. 1/sqrt(10) in this case. Is the standard
# deviation of this sampling distribution close to the analytic standard error?
1/sqrt(n)
sd(mu)

# we can use our understanding of sampling distributions and their dispersion
# to make inferences about the questions that we are interested in. If you have
# infinite sample size, the sampling distribution would be normal, but Gosset
# discovered that with finite samples (let those amongst us who haven't
# taken a finite sample throw the first stone) the sampling distribution of the 
# mean was t distributed with n-1 degrees of freedom. (as n increases the t converges
# on the normal)

curve(dnorm(x), -4, 4, lwd = 2)
curve(dt(x, n-1), -4, 4, col = "red", add = T, lwd = 2)

# so we see that the t has fatter tails than the normal, or is less "surprised"
# by more extreme values

# how do we use all this to make inferences? If we set our alpha to .05, we would
# test to see if our sample mean is out side the central 95% probability of the
# t distribution. If it is outside that, we think that it is unlikely that our
# data come from a distribution with a mean of 0 and reject the null hypothesis that
# the true mean is 0. 

# let's take a sample with mean of 1 and std. dev. of 1
set.seed(12042014)
samp <- rnorm(n, 1, 1)

# how does the mean of this sample fall on the sampling distribution of the mean?
curve(dt(x, n-1), -4,4, lwd = 2)

# to place our mean on this distribution, we have to convert it to a t-value,
# we do this by dividing the mean by the standard deviation of the distribution
# (i.e. the standard error of the mean)
se <- sd(samp)/sqrt(n)
t_val <- mean(samp)/se
abline(v = t_val, col = "blue", lwd = 2)

# is this mean outside the central 95% of the distribution?
abline(v = qt(c(.025, .975), n-1), col = "red", lwd = 2)

# it is! so we would be suspicious about our data coming from a distribution
# that has a mean of 0


# now calculate the probability of seeing a value this extreme or more assuming
# that the real mean is 0 (otherwise known as a p-value)
pt(t_val, n-1, lower.tail = F) + pt(-t_val, n-1)

t.test(samp)

# Confidence Intervals ----------------------------------------------------

# let's shift our focus to the other side of the null hypothesis testing coin
# and look at confidence intervals. The logic here is similar to a p-value. If
# we construct an interval around our sample mean that is equal to the distance
# that covers the central 95% of the sampling distribution, we would expect our
# interval to include the true mean 95% of the time. 

# so let's re-do what we did above, but instead of delineating the central 95% of the
# data, let's plot the same distance centered on our t-value
upr <- t_val + qt(.975, n-1)
lwr <- t_val + qt(.025, n-1)
curve(dt(x, n-1), -4, upr + .2, lwd = 2)
abline(v = t_val, col = "blue", lwd = 2)
abline(v = c(lwr, upr), col = "red", lwd = 2)

# so we see that our interval doesn't cross 0, but having the values on the scale
# of this t distribution is annoying, so we can transform it back onto the
# scale of our data using the standard error, Let's plot a histogram of our data
# and indicate the mean and confidence intervals with vertical lines
upr <- upr*se
lwr <- lwr*se
mu <- mean(samp)

hist(samp)
abline(v = c(mu, upr, lwr), col = c("blue", "red", "red"), lwd = 3)

# so if we take a sample from a population with mean mu, the sample mean will
# be in the central 95% of the sampling distribution of the mean 95% of the time,
# i.e. the confidence interval will cover the true value 95% of the time. Let's test
# this by taking 100 samples from a standard normal and see how often the
# 95% interval overlaps 0

n_samps <- 100

# sample it into a matrix to perform calculations on
samps <- matrix(rnorm(n*n_samps), ncol = n_samps)

# get the means of the replicate samples
mu_samps <- apply(samps, 2, mean)

# get standard error estimates (remember, standard errors are standard deviations of 
# sampling distributions--fu***ng statisticians)
se_samps <- apply(samps, 2, function(x) sd(x)/sqrt(n))

# remember to use the sample standard errors to scale the 2.5 and 97.5 t percentiles
# to the same space as the data

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
m <- rnorm(n, 1, 1)

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

# calculate bootstrap p-value
meds_p <- meds - median(m)
hist(meds_p)
sum(meds_p >= median(m) | meds_p <= -median(m))/length(meds_p)

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

# bootstrapped correlation

# let's try with a correlation, sample two random variables into
# a matrix y. Each variable has mean 0 and standard deviation 1, and they
# have a .7 correlation.
SIGMA <- matrix(c(1, .7, .7, 1), ncol = 2)
y <- MASS::mvrnorm(n, mu = c(0,0), Sigma = SIGMA)

# here's the analytic estimates of the confidence interval
cor.test(y[,1], y[,2])$conf.int


# this time, it's important to keep track of indices since a and b are not independent!
idx <- matrix(sample(1:n, n*10000, replace = T), ncol = 10000)

# calculate the correlation of each bootstrap
cor_boots <- apply(idx, 2, function(x) cor(y[x,1], y[x,2]))

# what is the 95% confidence interval?
quantile(cor_boots, c(.025, .975))

hist(cor_boots)
abline(v = cor(y[,1], y[,2]), lwd = 2)
abline(v = .7, col = "blue", lwd = 2)
abline(v = quantile(cor_boots, c(.025, .975)), col = "red", lwd = 2)



# Simple Regression Bootstraps --------------------------------------------

# there are a few ways to get bootstrap confidence intervals of regression 
# coefficients. The first we'll talk about is case resampling, which like we 
# did above, is we resample rows of data. Case resampling is appropriate when
# x-y pairs are sampled together from a population. If x is controlled for, you may
# want to use residual resampling (see below)

#Let's try it:
n <- 100
a <- 1
b <- .5
x <- rnorm(n)
y <- a + b*x + rnorm(n, 0)

# here is a plot of the data with the true relationship between x and y shown
plot(y ~ x, pch = 19)
abline(a = a, b= b)

# use case resampling to construct a 95% confidence interval around the estimate
# of b. You can use lm() and extract the coefficient, or recall that for univariate
# regression: b = cov(x, y)/var(x)
n_boot <- 1000

idx <- matrix(sample(1:n, n*n_boot, replace = T), ncol = n_boot)

b_hat <- apply(idx, 2, function(id) cov(x[id], y[id])/var(x[id]))

hist(b_hat)
abline(v = .5, col = "blue", lwd = 2)
abline(v = quantile(b_hat, c(.025, .975)), col = "red", lwd = 2)



# residual resampling

# first, fit the model
fit <- lm(y ~ x)

# extract the fitted values and residual values

e <- as.numeric(fit$residuals)

y_hat <- as.numeric(fit$fitted.values)

# now we resample with replacement the residuals

e_boot <- matrix(sample(e, n*n_boot, replace = T), ncol = n_boot)

# now estimate the coefficient for each bootstrap replicate
b_hat <- apply(e_boot, 2, function(r) cov(x, y_hat + r)/ var(x))

hist(b_hat)
abline(v = b, col = "blue", lwd = 2)
abline(v = quantile(b_hat, c(.025, .975)), col = "red", lwd = 2)


