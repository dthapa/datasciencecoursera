# program execution time
start.time <- proc.time()
print(paste('Current Working Directory', getwd()))

library(dplyr)

# dataset download and setup
dataSetURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
fileName <- 'getdata-projectfiles-UCI HAR Dataset.zip'
if (!file.exists(fileName)) {
    download.file(dataSetURL, fileName, method = 'curl')
    unzip(fileName)
}

# reading all features
features <- read.table('UCI HAR Dataset/features.txt', header = F)
names(features) <- c('id', 'name')
stopifnot(nrow(features) == 561)

# all activity labels
activities.label <- read.table('UCI HAR Dataset/activity_labels.txt', header = F)
names(activities.label) <- c('id', 'name')
stopifnot(nrow(activities.label) == 6)

# Uses descriptive activity names to name the activities in the data set
activities <- function(fileName) {
    activities <- read.table(fileName, header = F)
    names(activities) <- 'id'
    activities <- select(merge(activities, activities.label, by.x = 'id'), name)
}
activities.test <- activities('UCI HAR Dataset/test/y_test.txt')
stopifnot(nrow(activities.test) == 2947 & sum(is.na(activities.test$name)) == 0)
activities.train <- activities('UCI HAR Dataset/train/y_train.txt')
stopifnot(nrow(activities.train) == 7352 & sum(is.na(activities.train$name)) == 0)

# participants in the study
subjects <- function(fileName) {
    subjects <- read.table(fileName, header = F)
    names(subjects) <- 'subject.id'
    subjects
}
subjects.test <- subjects('UCI HAR Dataset/test/subject_test.txt')
stopifnot(nrow(subjects.test) == 2947)
subjects.train <- subjects('UCI HAR Dataset/train/subject_train.txt')
stopifnot(nrow(subjects.train) == 7352)

# Extracts only the measurements on the mean and standard deviation for each measurement
filter.mean.std <- grepl('.+mean\\(\\)|std\\(\\).+', features$name, ignore.case = T)
features <- filter(features, filter.mean.std)
stopifnot(nrow(features) == 57)

# reading test and training observations
testData <- read.table('UCI HAR Dataset/test/X_test.txt', header = F)
stopifnot(nrow(testData) == 2947 & length(names(testData)) == 561)
trainData <- read.table('UCI HAR Dataset/train/X_train.txt', header = F)
stopifnot(nrow(trainData) == 7352 & length(names(trainData)) == 561)

# select only the filtered features for mean and std
testData <- testData[, features$id]
trainData <- trainData[, features$id]
stopifnot(length(names(testData)) == nrow(features) 
          & length(names(trainData)) == nrow(features))
names(testData) <- features$name
names(trainData) <- features$name

# Appropriately labels the data set with descriptive variable names
setFeatureNames <- function(dataSource) {
    featureNames <- names(dataSource)
    featureNames <- gsub('Freq\\(\\)-(X|Y|Z)', '', featureNames)
    featureNames <- gsub('^t', 'timed', featureNames)
    featureNames <- gsub('^f', 'freq', featureNames)
    featureNames <- gsub('Acc', 'Acceleration', featureNames)
    featureNames <- gsub('Gyro', 'AngularVelocity', featureNames)
    featureNames <- gsub('Mag', 'Magnitude', featureNames)
    featureNames <- gsub('Jerk', 'JerkSignal', featureNames)
    featureNames <- gsub('-std\\(*\\)*', 'STD', featureNames)
    featureNames <- gsub('-mean\\(*\\)*', 'Mean', featureNames)
}
names(testData) <- setFeatureNames(testData)
names(trainData) <- names(testData)

# Merges the training and the test sets to create one data set.
testData$subject.id <- subjects.test$subject.id
testData$activity <- activities.test$name
trainData$subject.id <- subjects.train$subject.id
trainData$activity <- activities.train$name
allData <- rbind(testData, trainData)

# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- allData %>% 
    group_by(activity, subject.id) %>% 
    summarise_each(funs(mean)) %>% 
    arrange(subject.id)

# writing the tidy data to a csv file
write.csv(tidyData, 'tidyData.txt', row.names = F)
print('Tidy data has been written to tidyData.csv in the current working directory')
print(paste('Total elapsed time', as.character((proc.time() - start.time)[3]), 's'))