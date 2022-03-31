# This file is just to measure if the main code for BART is running well, isn't made for 
# evaluation purposes.

# Importing data and library
rm(list=ls())
library(purrr)
library(mlbench)
source("bart.R")
source("tree_manipulation_objects.R")
source("common_help_functions.R")

# Getting a simple train and test dataset
train_data <- mlbench.friedman1(n = 100,sd = 1)
x_train <- train_data$x
y_train <- train_data$y

test_data <- mlbench.friedman1(n = 100, sd = 1)
x_test <- test_data$x
y_test <- test_data$y

bart_mod <- bart(x = x_train,y = y_train,number_trees = 200,
                 control = list(node_min_size = 5,
                                scale_boolean = TRUE))

bart_pred <- predict(bart_mod = bart_mod, newdata = x_test, type = "mean")

dbart_mod <- dbarts::bart(x.train = x_train,
             y.train = y_train,
             ntree = 20, keeptrees = TRUE)

dbart_pred <- predict(dbart_mod, newdata = x_test) %>% colMeans
crossprod(y_test - dbart_pred)
crossprod(bart_pred - y_test)

# bart_pred
# y_test
plot(bart_pred,dbart_pred)
abline(a = 0 , b =1)
(unlist(bart_mod$tau_store)/(max(y_train)-min(y_train))^2)^(-1/2) %>% plot(type = "l")
dbart_mod$sigma %>% plot(type = "l")
