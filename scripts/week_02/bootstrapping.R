
# Quick Review of Inferential Stats --------------------------------------------------


# let's start by constructing a sampling distribution of the mean for a normal population with
# mean 0 and standard deviation of 1 and an n 0f 10.

# sample size


# number of replicate samples


# let's sample from this population 1000 times. We will store it in a matrix
# where each column is an independent sample


# now we will iterate over the columns and calculate the mean of each column (i.e.
# the mean of each independent sample)


# plot the histogram of these values (i.e. an approximation of the sampling
# distribution of the mean)


# the standard deviation of this distribution is the standard error of the mean,
# which we know analytically is sigma/sqrt(n), i.e. 1/sqrt(10) in this case. Is the standard
# deviation of this sampling distribution close to the analytic standard error?



# we can use our understanding of sampling distributions and their dispersion
# to make inferences about the questions that we are interested in. If you have
# infinite sample size, the sampling distribution would be normal, but Gosset
# discovered that with finite samples (let those amongst us who haven't
# taken a finite sample throw the first stone) the sampling distribution of the 
# mean was t distributed with n-1 degrees of freedom. (as n increases the t converges
# on the normal)




# so we see that the t has fatter tails than the normal, or is less "surprised"
# by more extreme values

# how do we use all this to make inferences? If we set our alpha to .05, we would
# test to see if our sample mean is out side the central 95% probability of the
# t distribution. If it is outside that, we think that it is unlikely that our
# data come from a distribution with a mean of 0 and reject the null hypothesis that
# the true mean is 0. 

# let's take a sample with mean of 1 and std. dev. of 1



# how does the mean of this sample fall on the sampling distribution of the mean?


# to place our mean on this distribution, we have to convert it to a t-value,
# we do this by dividing the mean by the standard deviation of the distribution
# (i.e. the standard error of the mean)




# is this mean outside the central 95% of the distribution?


# it is! so we would be suspicious about our data coming from a distribution
# that has a mean of 0


# now calculate the probability of seeing a value this extreme or more assuming
# that the real mean is 0 (otherwise known as a p-value)




# Confidence Intervals ----------------------------------------------------

# let's shift our focus to the other side of the null hypothesis testing coin
# and look at confidence intervals. The logic here is similar to a p-value. If
# we construct an interval around our sample mean that is equal to the distance
# that covers the central 95% of the sampling distribution, we would expect our
# interval to include the true mean 95% of the time. 

# so let's re-do what we did above, but instead of delineating the central 95% of the
# data, let's plot the same distance centered on our t-value







# so we see that our interval doesn't cross 0, but having the values on the scale
# of this t distribution is annoying, so we can transform it back onto the
# scale of our data using the standard error, Let's plot a histogram of our data
# and indicate the mean and confidence intervals with vertical lines







# so if we take a sample from a population with mean mu, the sample mean will
# be in the central 95% of the sampling distribution of the mean 95% of the time,
# i.e. the confidence interval will cover the true value 95% of the time. Let's test
# this by taking 100 samples from a standard normal and see how often the
# 95% interval overlaps 0



# sample it into a matrix to perform calculations on


# get the means of the replicate samples


# get standard error estimates (remember, standard errors are standard deviations of 
# sampling distributions--fu***ng statisticians)


# remember to use the sample standard errors to scale the 2.5 and 97.5 t percentiles
# to the same space as the data

# So our confidence intervals are...




## plot our 100 confidence intervals

# index for the intervals


# whether an interval contains the true value (0) + 1 to index color to make intervals
# that miss the true value red, and intervals that contain it 0




# create an empty plot to put the intervals in


# plot the intervals, make those that contain the true value black and those
# that don't red


# add a horizontal line to indicate the true value of the population



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



# we take our sample


# we take b re-samples with replacement



# and calculate the median for each bootstrap sample



# and our 95% confidence interval is...


# we can plot it:





# benefits of bootstrapping: flexible, maybe more realistic assumptions
# drawbacks: need to assume that the sample is representative of the population,
# i.e. a bad sample will give a bad confidence interval.

# try it out, take a sample from a population with two groups having some characteristic
# poisson distributed around the group mean. Group A has a mean of 2 and group B has
# a mean of 4. Sample 30 individuals from each group and use bootstrapping to 
# construct a 95% confidence interval of the difference in means between the groups (
# i.e. what is the confidence interval of mu_b - mu_a). Does the interval contain 0?
# does it contain the true value of 2?




# sample A
a <- rpois(n, 2)

# sample B
b <- rpois(n, 4)

# take 1000 bootstrap replicates of a and b, calculate the difference of the means




# what is the 95% confidence interval




# plot the sampling distribution of the difference of means




# bootstrapped correlation

# let's try with a correlation, sample two random variables into
# a matrix y. Each variable has mean 0 and standard deviation 1, and they
# have a .7 correlation.
SIGMA <- matrix(c(1, .7, .7, 1), ncol = 2)
y <- MASS::mvrnorm(n, mu = c(0,0), Sigma = SIGMA)

# here's the analytic estimates of the confidence interval
cor.test(y[,1], y[,2])$conf.int


# this time, it's important to keep track of indices since a and b are not independent!


# calculate the correlation of each bootstrap


# what is the 95% confidence interval?










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
y <- a + b*x + rnorm(n, 0, 1)

# here is a plot of the data with the true relationship between x and y shown
plot(y ~ x, pch = 19)
abline(a = a, b= b)

# use case resampling to construct a 95% confidence interval around the estimate
# of b. You can use lm() and extract the coefficient, or recall that for univariate
# regression: b = cov(x, y)/var(x)










# residual resampling

# first, fit the model


# extract the fitted values and residual values





# now we resample with replacement the residuals


# now estimate the coefficient for each bootstrap replicate




