
library(caret)
library(data.table)
library(Metrics)
library(dplyr)
library(tidyverse)


train <- read.csv("C://Users//zachh//Data//Stat_380_train.csv")
test <- read.csv("C://Users//zachh//Data//Stat_380_test.csv")
covar <- read.csv("C://Users//zachh//Data//covar_data.csv")
example <- read.csv("C://Users//zachh//Data//Example_Sub.csv")


group_avg <- train %>%
  group_by(qc_code) %>%
  summarize(SalePrice = mean(SalePrice, na.rm = TRUE))

test$ic50_Omicron <- NULL

lm_model <- lm(ic50_Omicron ~ age + centre + dose_2 + dose_3  + priorSxAtFirstVisit + days_sinceDose2 + days_dose12interval + posTest_beforeVisit, data = train)
summary(lm_model)

test$ic50_Omicron <- predict(lm_model, newdata = test)

submit <- select(test, sample_id, ic50_Omicron)

write_csv(submit, path = "submit.csv")



