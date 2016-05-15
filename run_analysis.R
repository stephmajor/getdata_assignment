## R script for Getting Data course final assignment
## this script should be sourced from a folder that contains the folder "UCI HAR Dataset"
##
## the script produces a tidy dataset with all observatsions called "analysis_data"
## the script produces a tidy summary dataset with averaged data by subject & activity called "averaged_data"
##
library(data.table)
top_dir <- "UCI HAR Dataset"

## 1. by merging all the data together into one largeline (slow running commands)
##   - collect all data for test and train
##   - bind all rows together in 1 large data frame (train followed by test)
##   - replace variable names by proper names

train <- read.fwf(paste(top_dir, "train", "X_train.txt", sep = "/"), rep.int(16, 561))
test <- read.fwf(paste(top_dir, "test", "X_test.txt", sep = "/"), rep.int(16, 561))
all_data <- rbind(train, test)

# get the features from features.txt
features_raw <- readLines(paste(top_dir, "features.txt", sep = "/"))
features_list <- sapply(features_raw, strsplit, " ")
features <- matrix(unlist(features_list), ncol = 2, byrow = TRUE)[,2]

# use the features as column names (before the selection of columns)
colnames(all_data) <- features

## 2. extract the measurements for mean & standard deviation (look for mean() or std() in column name)
all_data <- all_data[,grep("(-mean\\(|-std\\()", features)]

# improve on the name of the variables: t -> time f -> frequency remove "()" & "-" & set to lower case
fixName <- function(x) {
  tolower(sub("^f", "frequency", sub("^t", "time", sub("\\(\\)", "", gsub("-", "", x[1])))))
}
colnames(all_data) <- unlist(sapply(colnames(all_data), fixName))

## 3. collect information about labels for substitution in the dataset

activity_labels_raw <- readLines(paste(top_dir, "activity_labels.txt", sep = "/"))
activity_labels_list <- sapply(activity_labels_raw, strsplit, " ")
activity_labels <- matrix(unlist(activity_labels_list), ncol = 2, byrow = TRUE)[,2]

## 4. add columns for the subject and the activity (label)

# read and prepare the activity column (train followed by test)
train_activities <- read.fwf(paste(top_dir, "train", "y_train.txt", sep = "/"), c(1))
test_activities <- read.fwf(paste(top_dir, "test", "y_test.txt", sep = "/"), c(1))
all_activities <- rbind(train_activities, test_activities)
colnames(all_activities) <- c("activity")

# swap in the proper activity label and make it a factor
swapLabel <- function(x) { activity_labels[x[1]] }
all_activities$activity <- sapply(all_activities$activity, swapLabel)
all_activities$activity <- as.factor(all_activities$activity)

# read and prepare the subject column (train followed by test)
train_subjects <- read.fwf(paste(top_dir, "train", "subject_train.txt", sep = "/"), c(1))
test_subjects <- read.fwf(paste(top_dir, "test", "subject_test.txt", sep = "/"), c(1))
all_subjects <- rbind(train_subjects, test_subjects)
colnames(all_subjects) <- c("subject")

# make subject a factor instead of an int, since the "int" has no value here
all_subjects$subject <- as.factor(all_subjects$subject)

# bind the new columns to the final data frame
analysis_data <- cbind(all_subjects, all_activities, all_data)

## 5. create summary table, with averages by activity and by subject
dt <- data.table(analysis_data)
averaged_data <- data.frame(dt[, lapply(.SD, mean), by = list(subject,activity)])

# make sure the column reflect the fact that the data is averaged
renameCol <- function(x) { paste0("average", x[1]) }
colnames(averaged_data) <- c("subject", "activity", unlist(sapply(colnames(all_data), renameCol), use.names = FALSE))

# we could here remove all intermediate variables that were created if we needed to leave the environment clean
