
library(caret)
library(data.table)
library(Metrics)
library(dplyr)
library(tidyverse)


train <- read.csv("C://Users//zachh//Desktop//Data//Stat_380_test.csv")
test <- read.csv("C://Users//zachh//Data//Stat_380_test.csv")
covar <- read.csv("C://Users//zachh//Data//covar_data.csv")
example <- read.csv("C://Users//zachh//Data//Example_Sub.csv")