# Loading packages
library(cppbart)
library(tidyverse)


# devtools::load_all()
n_obs <- 200
x <- matrix(seq(-pi,pi,length.out = n_obs))
colnames(x) <- "x"
y <- c(sin(x)) + rnorm(n = n_obs,sd = 0.1)

y_vec <- c(y)

summary_comparison <- microbenchmark::microbenchmark(bart(x = x,y = y,
                                                          number_trees = 200,
                                                          control =  list(node_min_size = 1,
                                                                          scale_boolean =  TRUE),
                                                          mcmc_parameter = list(n_iter = 2000,burn = 500,thin = 1)),
                                                     r_bart(x = x,y = y,n_tree = 200,n_mcmc = 2000,n_burn = 500,n_min_size = 1,
                                                            tau = 1,mu = 0,alpha = 0.95,beta = 2,
                                                            scale_boolean = TRUE,a_tau = 3,d_tau = 3,
                                                            prob_tau = 0.9,K_bart = 2),times = 10)

summary_comparison
