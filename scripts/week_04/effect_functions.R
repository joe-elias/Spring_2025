# Functions and workspace set up -----------------------------------------------

# convert standard error to standard deviation
se2sd <- function(se, n){
  se*sqrt(n)
}

# calculated pooled standard deviation
pool_sd <- function(n1, n2, sd1, sd2){
  sqrt((((n1 - 1)*sd1*sd1) + ((n2-1)*sd2*sd2))/(n1 + n2 -2))
}

# functions to calculate a pre-post-control-treatment effect
cp <- function(n1, n2){
  1 - (3/(4*(n1+n2-2)-1))
}

dppc2 <- function(m1p, m1s, m2p, m2s, sdp, cp){
  cp*(((m1s - m1p) - (m2s - m2p))/sdp)
}

calc_dppc2 <- function(m1p, m1s, m2p, m2s, n1, n2, sd1, sd2){
  CP <- cp(n1, n2)
  sdp <- pool_sd(n1, n2, sd1, sd2)
  dppc2(m1p, m1s, m2p, m2s, sdp, CP)
}

ci2sd <- function(li, ui, N){
  sqrt(N) * (ui - li)/(qt(0.975, N-1)*2)
}

iqr2mean <- function(q1, med, q3){
  (q1+med+q3)/3
}

iqr2sd <- function(q1, q3, n){
  (q3 - q1)/(2*qnorm((0.75*n - 0.125)/(n + 0.25), 0, 1))
  #=($D17-$B17)/(2*_xlfn.NORM.INV((0.75*$E17-0.125)/($E17+0.25),0,1))
  # from Wan et al
}


# Plots ------------
calc_i2 <- function(mod){
  W <- diag(1/mod$vi)
  X <- model.matrix(mod)
  P <- W - W %*% X %*% solve(t(X) %*% W %*% X) %*% t(X) %*% W
  I2 <- 100 * sum(mod$sigma2) / (sum(mod$sigma2) + (mod$k-mod$p)/sum(diag(P)))
  return(I2)
}

make_squares <- function(mod){
  wi <- weights(mod)
  psize <- wi/sum(wi, na.rm = TRUE)
  rng <- max(psize, na.rm = TRUE) - min(psize, na.rm = TRUE)
  k <- length(wi)
  if (rng <= .Machine$double.eps^0.5) {
    psize <- rep(1, k)
  }else {
    psize <- (psize - min(psize, na.rm = TRUE))/rng
    psize <- (psize * 1) + 0.5
  }
  if (all(is.na(psize))){
    psize <- rep(1, k)
  } 
  return(psize)
}

plot_forest <- function(mod, labels){
  par(xpd=F)
  xvals <- seq(-5, 5, 0.5)
  upci <- max(max(mod$yi + 1.96*sqrt(mod$vi), na.rm = T), mod$ci.ub)
  lowci <- min(min((mod$yi - 1.96*sqrt(mod$vi)), na.rm=T), mod$lb)
  xlims <- c(xvals[max(which(xvals<lowci))], xvals[min(which(xvals>upci))])
  ylims <- c(1, nrow(predict(mod)))
  
  metafor::forest(mod, slab=labels, 
                  cex.lab=1, xlab="Effect")
  
  text(x=xlims[1], y=length(weights(mod))+c(3), cex=1, adj=0, 
       bquote(paste("Q = ", .(formatC(mod$QE, digits=2, format="f")),
                    "; df = ", .(formatC(mod$k - mod$p, digits=2, format="f")),
                    "; p = ", .(formatC(mod$QEp, digits=2, format="f")))))
  
  I2 <- calc_i2(mod)
  
  text(x=xlims[1], y=length(weights(mod))+c(2), 
       adj=0, bquote(paste(I^2, " = ", .(formatC(I2, digits=2, format="f")), "; ", tau^2, " = ", .(formatC(mod$tau2, digits=2, format="f")))),
       cex=1)
}


