
library(caret)
library(data.table)
library(Metrics)
library(dplyr)
library(tidyverse)


train <- read.csv("C://Users//zachh//Data//Stat_380_train.csv")
test <- read.csv("C://Users//zachh//Data//Stat_380_test.csv")
covar <- read.csv("C://Users//zachh//Data//covar_data.csv")
example <- read.csv("C://Users//zachh//Data//Example_Sub.csv")

test$ic50_Omicron <- 0

str(train)

numeric_cols <- sapply(train, is.numeric)
train[numeric_cols] <- lapply(train[numeric_cols], function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))
test[numeric_cols] <- lapply(test[numeric_cols], function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))

model <- lm(ic50_Omicron ~ age + sex + centre + dose_2 + dose_3 + Sx_severity_most_recent + priorSxAtFirstVisit + priorSxAtFirstVisitSeverity + days_sinceDose2 + days_sinceDose3 + days_dose12interval + days_dose23interval + days_sinceSxLatest + days_sincePosTest_latest + posTest_beforeVisit, data = train)
summary(model)

test$ic50_Omicron <- predict(model, newdata = test)

test$ic50_Omicron <- abs(test$ic50_Omicron)

submit <- select(test, sample_id, ic50_Omicron)

write_csv(submit, path = "submit.csv")



