library(readr)
library(plyr)

if(!file.exists("./samsungdataset.zip"))
{
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./samsungdataset.zip")
}
unzip("./samsungdataset.zip")

# Read the feature names from features.txt
features <- read_delim("./UCI HAR Dataset/features.txt", delim = " ",col_names = FALSE)

# Assign column names
names(features) <- c("index", "variable")

# Find the mean and standard deviation variables
mean_std <- grep("mean|std", features$variable)

# Read the activity names from activity_labels.txt
activities <- read_delim("./UCI HAR Dataset/activity_labels.txt", delim = " ",col_names = FALSE)
names(activities) <- c("activityid", "activityname")

# Read the test data set 
test <- read_fwf("./UCI HAR Dataset/test/X_test.txt", col_positions = fwf_widths(rep(16, 561)))
test <- test[,mean_std]         # Keep only the columns with mean and standard deviation in their name
names(test) <- features$variable[mean_std]      # Set the variable names to the ones from the features file.
test_subjects <- read_table("./UCI HAR Dataset/test/subject_test.txt", col_names = c("subject"))   # Read the subjects file
test$subject <- test_subjects$subject   # Append the subject column to the data frame
test_activities <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = c("activityid"))   # Read the test activity labels
test$activityid <- test_activities$activityid

# Repeat above steps for the train set
train <- read_fwf("./UCI HAR Dataset/train/X_train.txt", col_positions = fwf_widths(rep(16, 561)))
train <- train[,mean_std]
names(train) <- features$variable[mean_std]
train_subjects <- read_table("./UCI HAR Dataset/train/subject_train.txt", col_names = c("subject"))
train$subject <- train_subjects$subject
train_activities <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = c("activityid"))  
train$activityid <- train_activities$activityid

mergedData <- rbind.fill(test, train)

# Convert the activityid column to a factor with labels from activities to make the ids readable
mergedData$activityid <- factor(mergedData$activityid, labels = activities$activityname)

# Calculate mean of each variable grouped by subject and activity 
subject_activity_means <- aggregate(. ~ subject + activityid, mergedData, mean)

# Write the tidy merged dataset to smartphoneactivity
write.table(mergedData, file = "./smartphoneactivity.txt", row.names = FALSE)

# Write the table with activity means by subject and activity into subjectactivitymean.txt
write.table(subject_activity_means, file = "./subjectactivitymeans.txt", row.names = FALSE)
