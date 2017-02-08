library(dplyr)
library(caret)
library(ggplot2)
library(plotly)
library(reshape2)
library(googleVis)

set.seed(1234)
hr <- read.csv('HR_comma_sep.csv')
hr <- rename(hr, dept = sales)

best_evaluated <- filter(hr, last_evaluation > 0.8)
inTrain <- createDataPartition(best_evaluated$left, p = 0.7, list = FALSE)
train <- best_evaluated[inTrain, ]
test <- best_evaluated[-inTrain, ]
modelGLM <- step(glm(left ~ . -last_evaluation, data = train, family = binomial))
#tr.Control <- trainControl(method = 'repeatedcv', repeats = 1, number = 10, allowParallel = TRUE)
#modelRF <- train(left ~ satisfaction_level + number_project + average_montly_hours + 
#                     time_spend_company + Work_accident + promotion_last_5years + 
#                     salary, data = train, method = 'rf', ntree = 10, do.trace = 1,
#                 trControl = tr.Control)
load("modelRF.RData")
