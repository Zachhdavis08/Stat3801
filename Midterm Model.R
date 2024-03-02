
library(caret)
library(data.table)
library(Metrics)
library(dplyr)
library(tidyverse)
library(glmnet)
library(mice)
set.seed(21)

train <- read.csv("C://Users//zachh//Data//Stat_380_train.csv")
test <- read.csv("C://Users//zachh//Data//Stat_380_test.csv")
covar <- read.csv("C://Users//zachh//Data//covar_data.csv")
example <- read.csv("C://Users//zachh//Data//Example_Sub.csv")

test$ic50_Omicron <- 0

merged_train <- merge(train, covar, by = "sample_id")
merged_test <- merge(test, covar, by = "sample_id")


merged_train <- data.table(train)
merged_test <- data.table(test)

drops <- c('sample_id', 'sex', 'centre', 'dose_2', 'dose_3', 'priorSxAtFirstVisit', 'priorSxAtFirstVisitSeverity', 'posTest_beforeVisit')

merged_train <- merged_train[, !drops, with = FALSE]
merged_test <- merged_test[, !drops, with = FALSE]

train_y <- merged_train$ic50_Omicron

gl_model <- cv.glmnet(train, train_y, alpha = 1,family="gaussian")

merged_train <- merge(train, covar, by = "sample_id")

merged_train <- merge(train, covar, by = "sample_id")

# Handle missing values in merged_train (if needed)
merged_train[is.na(merged_train)] <- 0  # Impute missing values with 0 (for binary variables)

# Encode categorical variables in merged_train (if needed)
# Example: One-hot encoding for categorical variables
merged_train <- model.matrix(~., data = merged_train)

# Separate predictors and response variable in merged_train
x_train <- merged_train[, -1]  # Exclude the response variable
y_train <- merged_train$ic50_Omicron

# Train the model using glmnet
library(glmnet)
model <- glmnet(x_train, y_train, alpha = 1)

# Prepare the test dataset
merged_test <- merge(test, covar, by = "sample_id")

# Handle missing values and encode categorical variables in merged_test (if needed)
# Ensure that the preprocessing steps are consistent with those applied to the training data

# Make predictions using the trained model
x_test <- merged_test  # Assuming preprocessing steps are completed
predictions <- predict(model, newx = x_test)

submission <- data.frame(sample_id = merged_test$sample_id, ic50_Omicron = predictions)

# Write the submission to a CSV file
write.csv(submission, file = "submit.csv", row.names = FALSE)

