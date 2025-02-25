#packages needed for this code
library(readxl)
library(tidyverse)
library(car)
library(emmeans)

#Loading in the data
Sal <- read_excel("UNHSalamander.xlsx")

#renaming hue column to redness for the sake of continuity in the paper


#subsetting data into sites (might be useful for later when we are playing around with the data)
SalCW <- subset(Sal, site == "CW")
SalM <- subset(Sal, site == "M")
SalMD <- subset(Sal, site == "MD")

#checking for a visual association between length and weight
plot(Sal$weight ~ Sal$length, pch=20)

#correlation test between length and weight for all sites
cor.test(Sal$length, Sal$weight)

#since length and weight are significantly correlated, the weight residuals (weight~length) will be used for further analysis to remove any covariation. 
regressionweight <- lm(Sal$weight ~ Sal$length, data=Sal)
summary(regressionweight)

#since weight residuals are going to be used for further analyses, I want to add this as a column to my data frame
resweight <- resid(regressionweight)
Sal$weightresidual <- resweight

#-------Model creation and selection---------
smod1 <- lm(maxsprint ~ redness + intensity + ambtemp + weightresidual + length + site, data=Sal)
summary(smod1)

step(smod1, direction ="backward")

#you can create a vector with what the most complex model could be and have the step function run through it "forwards"
smod2 <- lm(maxsprint ~ 1, data=Gsal)
biggest <- formula(lm(maxsprint~ redness + intensity + ambtemp + weightresidual + length + site, data=Sal))
step(smod2, direction = "forward", scope = biggest)

#site smod1 narrowed down the variables affecting sprint speed to just site, looked at an interaction of color and site as a possible relevant effect
smod3 <- lm(maxsprint ~ redness*site + intensity*site + weightresidual + length + ambtemp, data= Sal)
summary(smod3)

#use the step function to inform what to remove from the model to make it more informative
step(smod3)

#continuing to trial models that are biologically relevant to see if any are significant based on information from the step(smod3) output
smod4 <- lm(maxsprint ~ redness*site + weightresidual + length + ambtemp, data= Sal)
summary(smod4)
smod5 <- lm(maxsprint ~ redness*site + weightresidual + ambtemp, data= Sal)
summary(smod5)

#Running a type 2 ANOVA
Anova(smod5)

#estimated marginal means of linear trends. Looking at differences betwewen slopes
trend <- emtrends(smod5, pairwise ~ site, var="redness")
summary(trend)
#can also use the function contrast as a post-hoc test, but it gives the same results as summary in this case
contrast(trend$emtrends, method = "pairwise")

#Lets graph it to compare linear trends!


#I also want to compare redness across sites since there is an interaction between redness and site
redaov <- aov(Gsal$redness ~ Gsal$site)
summary(redaov)

#Woo significance! I wonder which sites it's between...
TukeyHSD(redaov)

#More graphing! Lets visualize the distribution of points between the three sites



#------Time to play around with the data----------
