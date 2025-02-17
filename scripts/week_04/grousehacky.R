install.packages("metafor")
library(metafor)

# Functions --------------------------------------------------------------------
source("effect_functions.R")

# Read in data -----------------------------------------------------------------
# Read in the spreadsheet with metadata
meta.dat <- as.data.frame(read.csv("Grouse meta-analysis - articles (2).csv"))
meta.dat$ES_ID <- paste(meta.dat$Article_ID,meta.dat$ES_ID)

# Read in combined effect size data sheet 
es.dat <- read.csv("grouse_es4.csv")
es.dat <- es.dat[!is.na(es.dat$Article_ID),]

#take everything but first 12 columns of es.dat and removes commas and turns things into numbers 
es.dat[,-c(1:12)] <- apply(es.dat[,-c(1:12)], 2, function(x){as.numeric(gsub(",", "", x))})
es.dat$ES_ID <- paste(es.dat$Article_ID,es.dat$ES_ID)

# Calculate effect sizes -------------------------------------------------------

es.dat$sd1[(is.na(es.dat$sd1) & !is.na(es.dat$se1))] <- se2sd(es.dat$se1[(is.na(es.dat$sd1) & !is.na(es.dat$se1))],
                                                              n=es.dat$n1[(is.na(es.dat$sd1) & !is.na(es.dat$se1))])
es.dat$sd2[(is.na(es.dat$sd2) & !is.na(es.dat$se2))] <- se2sd(es.dat$se2[(is.na(es.dat$sd2) & !is.na(es.dat$se2))],
                                                              n=es.dat$n2[(is.na(es.dat$sd2) & !is.na(es.dat$se2))])

es.dat$sd1p[(is.na(es.dat$sd1p) & !is.na(es.dat$se1p))] <- se2sd(es.dat$se1p[(is.na(es.dat$sd1p) & !is.na(es.dat$se1p))],
                                                                 n=es.dat$n1p[(is.na(es.dat$sd1p) & !is.na(es.dat$se1p))])
es.dat$sd1s[(is.na(es.dat$sd1s) & !is.na(es.dat$se1s))] <- se2sd(es.dat$se1s[(is.na(es.dat$sd1s) & !is.na(es.dat$se1s))],
                                                                 n=es.dat$n1s[(is.na(es.dat$sd1s) & !is.na(es.dat$se1s))])
es.dat$sd2p[(is.na(es.dat$sd2p) & !is.na(es.dat$se2p))] <- se2sd(es.dat$se2p[(is.na(es.dat$sd2p) & !is.na(es.dat$se2p))],
                                                                 n=es.dat$n2p[(is.na(es.dat$sd2p) & !is.na(es.dat$se2p))])
es.dat$sd2s[(is.na(es.dat$sd2s) & !is.na(es.dat$se2s))] <- se2sd(es.dat$se2s[(is.na(es.dat$sd2s) & !is.na(es.dat$se2s))],
                                                                 n=es.dat$n2s[(is.na(es.dat$sd2s) & !is.na(es.dat$se2s))])
# Medians and IQR to mean  and SD ------------

tmp.sub <- (is.na(es.dat$m1) & !is.na(es.dat$med.1))
es.dat$m1[tmp.sub] <- metaDigitise::rqm_to_mean(es.dat$min.1[tmp.sub], es.dat$q1.1[tmp.sub],
                                                es.dat$med.1[tmp.sub], es.dat$q3.1[tmp.sub], es.dat$max.1[tmp.sub], es.dat$n1[tmp.sub])
es.dat$sd1[tmp.sub] <- metaDigitise::rqm_to_sd(es.dat$min.1[tmp.sub], es.dat$q1.1[tmp.sub],
                                               es.dat$q3.1[tmp.sub], es.dat$max.1[tmp.sub], es.dat$n1[tmp.sub])

tmp.sub <- (is.na(es.dat$m2) & !is.na(es.dat$med.2))
es.dat$m2[tmp.sub] <- metaDigitise::rqm_to_mean(es.dat$min.2[tmp.sub], es.dat$q1.2[tmp.sub],
                                                es.dat$med.2[tmp.sub], es.dat$q3.2[tmp.sub], es.dat$max.2[tmp.sub], es.dat$n2[tmp.sub])
es.dat$sd2[tmp.sub] <- metaDigitise::rqm_to_sd(es.dat$min.2[tmp.sub], es.dat$q1.2[tmp.sub],
                                               es.dat$q3.2[tmp.sub], es.dat$max.2[tmp.sub], es.dat$n2[tmp.sub])

tmp.sub <- (is.na(es.dat$m1) & !is.na(es.dat$med.1))
es.dat$m1[tmp.sub] <- iqr2mean(es.dat$q1.1[tmp.sub], es.dat$med.1[tmp.sub], es.dat$q3.1[tmp.sub])
es.dat$sd1[tmp.sub] <- iqr2sd(es.dat$q1.1[tmp.sub], es.dat$q3.1[tmp.sub], es.dat$n1[tmp.sub])

tmp.sub <- (is.na(es.dat$m2) & !is.na(es.dat$med.2))
es.dat$m2[tmp.sub] <- iqr2mean(es.dat$q1.2[tmp.sub], es.dat$med.2[tmp.sub], es.dat$q3.2[tmp.sub])
es.dat$sd2[tmp.sub] <- iqr2sd(es.dat$q1.2[tmp.sub], es.dat$q3.2[tmp.sub], es.dat$n2[tmp.sub])


# Confidence interval to SD -----------

es.dat$sd1[tmp.sub] <- ci2sd(es.dat$ciL1[tmp.sub], es.dat$ciU1[tmp.sub], es.dat$n1[tmp.sub])
es.dat$sd2[tmp.sub] <- ci2sd(es.dat$ciL2[tmp.sub], es.dat$ciU2[tmp.sub], es.dat$n2[tmp.sub])

# Calculate effect sizes ----------------------

# SMDs
smd <- metafor::escalc("SMD", n1i=es.dat$n1, n2i=es.dat$n2, 
                       m1i=es.dat$m1, m2i=es.dat$m2, 
                       sd1i=es.dat$sd1, sd2i=es.dat$sd2)
smd <- as.numeric(effectsize::d_to_r(smd$yi))

# Means and SDs, pre- and post-treatment with control
ppc <- calc_dppc2(es.dat$m1p, es.dat$m1s, 
                  es.dat$m2p, es.dat$m2s, 
                  es.dat$n1p, es.dat$n2p, 
                  es.dat$sd1p, es.dat$sd2p)
ppc <- effectsize::d_to_r(ppc)
# Proportions
oddratio <- metafor::escalc("OR", ai=es.dat$n1*es.dat$prop1, bi=es.dat$n1*(1-es.dat$prop1), n1i = es.dat$n1,
                            ci=es.dat$n2*es.dat$prop2, di=es.dat$n2*(1-es.dat$prop2), n2i = es.dat$n2)
oddratio <- as.numeric(effectsize::oddsratio_to_r(exp(oddratio[,1])))

# r, r2s, and etas
r <- metafor::escalc("COR", ri=es.dat$r, ni=es.dat$n1)
r <- as.numeric(r$yi)
r2s <- sqrt(es.dat$R.)
etas <- effectsize::d_to_r(esc::cohens_d(eta=es.dat$η2))

# t-tests
# We set up the spreadsheet in a silly way and need to separate the df from 
# t-tests from df from other tests with a numerator and denominator (e.g. F)
tdf <- rep(NA, nrow(es.dat))
tdf[!is.na(es.dat$t)] <- es.dat$df[!is.na(es.dat$t)]
tdf <- as.numeric(tdf)
t2 <- es.dat$t
t2[is.na(tdf)] <- NA

ts <- rep(NA, nrow(es.dat))
for(i in 1:length(t2)){
  if(!is.na(t2[i])){
    ts[i] <- effectsize::d_to_r(effectsize::t_to_d(t2[i], tdf[i])$d)
  }
}


# # F values - CALCULATE MANUALLY
# fs <- c()
# for(i in 1:nrow(es.dat)){
#   if(!is.na(es.dat$F[i])){
#     fs[i] <- effectsize::F_to_d(es.dat$F[i], df = es.dat$df1[i], df_error = es.dat$df2[i])
#   }
# }

# z scores
z <- effectsize::z_to_r(es.dat$z, n=es.dat$N)$r

# betas
betas <- effectsize::d_to_r(es.dat$β/(sqrt(es.dat$N)*es.dat$se))

# Don't have any of these yet but may need in the future
# chi-square
# tmp <- as.numeric(es.dat$χ2)
# tmp[which(!is.na(tmp))] <- effectsize::d_to_r(esc::esc_chisq(tmp[which(!is.na(tmp))], totaln=as.numeric(es.dat$N[which(!is.na(tmp))]))[1]$es)
# chisquares <- tmp

# Cohen's D for studies with other effects
# Mostly, we manually calculated these using the Campbell calculator for F-tests
ds <- effectsize::d_to_r(es.dat$d)

# Merge all effects and resolve multiples --------------------------------------
effects <- cbind(ds, smd, ppc, oddratio, r, etas, betas, r2s, z, ts)*-1
effects[!is.na(ds),-1] <- NA


# Note: if there are multiple effects per study, we will need to resolve those
# based on the most reliable measure, but this will all be post-hoc
write.csv(effects, file="./duplicate-effects-check.csv")

#no duplicated when checked file 

table(apply(effects, 1, function(x){sum(!is.na(x))}))
which(apply(effects, 1, function(x){sum(!is.na(x))})>1)
effects[1,'betas'] <- NA

# These are missing or not calculable, e.g. might just be means 
es.dat$ES_ID[apply(effects, 1, function(x){sum(!is.na(x))})==0]
es.dat$sd1[apply(effects, 1, function(x){sum(!is.na(x))})==0]


effects
which(apply(effects, 1, function(x){sum(!is.na(x))})>1)


# Study-level effects and sample sizes -----------------------------------------
# for articles with multiple calculable effects, we need to manually check those
# for now, let's just use the mean to get to the analysis code
effects <- apply(effects, 1, mean, na.rm=T)
effects[abs(effects)>1] <- NA

names(effects) <- trimws(es.dat$ES_ID)
#names(effects) <- es.dat$ArticleID
#names(effects) <- paste(es.dat$ArticleID, es.dat$Test_ID, sep="_")

# Sample sizes
Ns <- cbind(as.numeric(es.dat$N), as.numeric(es.dat$n1+es.dat$n2), as.numeric(es.dat$n1p+es.dat$n2p))
Ns[is.na(Ns[,1]),1] <- Ns[is.na(Ns[,1]),2]
Ns[is.na(Ns[,1]),1] <- Ns[is.na(Ns[,1]),3]

studyN <- Ns[,1]
names(studyN) <- es.dat$ES_ID #paste(es.dat$ArticleID, es.dat$Test_ID, sep="_")

# Need to add in effect calculation for median/IQR data
# And need to go back to studies with means but not SD/SE to check if
# there are t-tests or anything simple like that for ES calculation

# Merge effects with metadata --------------------------------------------------

md <- meta.dat[match(names(effects), meta.dat$ES_ID),]
names(effects)[is.na(match(names(effects),meta.dat$ES_ID))]


es.dat$Direction.of.effect <- trimws(es.dat$Direction.of.effect)
effects[es.dat$Direction.of.effect=="positive"] <- abs(effects[es.dat$Direction.of.effect=="positive"])
effects[es.dat$Direction.of.effect=="negative"] <- abs(effects[es.dat$Direction.of.effect=="negative"])*c(-1)

es.dat$extype[es.dat$extype %in% c("captive variation", "starvation")] <- "deprivation"
es.dat$Habtype[es.dat$Habtype%in%c("agriculture", "agriculture ")] <- "agriculture"


#####Writing our mixed-effect models

#Now without starvation experiments



##### Plotting 
# First, lets check out the distribution of effects 
# what kind of distribution are we looking for? 


# Lets check out effects over sample size 


# Now, lets visualize publication bias/heterogeneity


# We can also make a forest plot to visualize all our effects


# Plot moderators
# Experiment type


# Now we can zhuzh it up by adding our data points on top of boxplot


# Average adult body size


# Exclude starvation


# Average clutch size 


#Exclude starvation
