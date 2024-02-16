
library(caret)
library(data.table)
library(Metrics)
library(dplyr)
library(tidyverse)
set.seed(77)


train <- read.csv("C://Users//zachh//Data//train_file.csv")
test <- read.csv("C://Users//zachh//Data//test_file.csv")
example <- read.csv("C://Users//zachh//Data//samp_sub.csv")

model <- glm(result ~ ., data = train[, -1], family = "binomial")


test_subset <- test[, -1] 
result <- predict(model, newdata = test_subset, type = "response")


test$result <- result

submit <- select(test, id, result)
submit <- test[, c("id", "result")]

write_csv(submit, path = "submit.csv")
