# run_analysis.R
# Created in: May 29, 2017
# Author: Adam Kreitzman


download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "file.zip")
unzip("file.zip")
setwd("UCI HAR Dataset/")

# 1. Merges the training and the test sets to create one data set.
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
X_all <- rbind(X_test, X_train)
y_all <- rbind(y_test, y_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
X_means <- apply(X_all, 1, mean)
X_StanD <- apply(X_all, 1, sd)

# 3. Uses descriptive activity names to name the activities in the data set
labels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
y_all_labels <- merge(y_all, labels, all=FALSE)

# 4. Appropriately labels the data set with descriptive variable names.
y_all <- y_all_labels$V2

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
aggregated <- aggregate(X_all, by=list('activity' = y_all), mean)

write.csv(aggregated, 'aggregated.csv', row.names = FALSE, quote = FALSE)
