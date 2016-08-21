---
title: "README"
author: "Raza Naqvi"
date: "August 20, 2016"
output: html_document
---

Method:
---

All the analysis is performed by the script run_analysis.R. The script downloads the zip file containing all the data and unzips it in the original directory structure. It reads all the variable names from features.txt. Next, it finds all the variables with "mean" and "std" in their names to restrict the selection to only mean and standard deviation variables.

The names of the six activities are read from the activity_labels.txt file so the activity IDs can be decoded into readable text

The script performs the following operations on the test data set and then repeats these steps for the train data set:

1. Reads the observations from X_test.txt into the "test" data set.
2. Subsets the data to only columns that contain "mean" or "std".
3. Replaces the generic variable names (V1, V2, etc.) with the variable names read earlier from the features.txt file.
4. Reads the subject_test.txt to identify the subjects corresponding to each observation.
5. Adds the subject column from the previous step to the test data set.
6. Reads the y_test.txt to identify the activity being performed for each observation.
7. Adds the activityid column from the previous step to the test data set.

Next, the test and train data sets are merged together into mergedData set.

The activityid column is converted into a factor with six levels using the activity labels

At this point we have a tidy data set with only the variables containing mean and standard deviation in their name, one column per variable and one observation per row. It also conforms to the project requirements of using descriptive activity names and descriptive variable names.

The aggregate function is used to calculate the average of each variable for each activity and each subject.

The tidy data set for the activities is written out to smartphoneactivity.txt and the tidy data set for the average of each variable is written out to subjectactivitymeans.txt.

---

Reading the data
---
Since the variable names contain hyphens and parentheses, use check.names = FALSE parameter to preserve them with read.table

```
data <- read.table("./subjectactivitymeans.txt", header = TRUE, check.names = FALSE)
View(data)
```

---

Original source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data for the project was obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Citations:
---
1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
2. Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1-29.
  URL http://www.jstatsoft.org/v40/i01/.
3. Hadley Wickham, Jim Hester and Romain Francois (2016). readr: Read Tabular Data. R package version 1.0.0.
  https://CRAN.R-project.org/package=readr
4. Hood, David. "Getting and Cleaning The Assignment." Web log post. N.p., 9 Sept. 2015. Web. 20 Aug. 2016.      https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment
