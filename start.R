rm(list = ls())

#install.packages("nnet")

library (tseries)
library (xts)
library (zoo)
library (quantmod)
library (neuralnet)

code_stock <- readline("Choose the Stock you want to predict: ")