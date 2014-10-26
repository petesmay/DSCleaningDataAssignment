Getting and Cleaning Data Course Project
========================================

The purpose of this project is to collect, work with, and clean a data set; to provide a tidy data set that can be used for later analysis.

## Repository Contents

This repository consists of:
1. this README.md
2. run_analysis.R
3. CodeBook.md

### run_analysis.R

This R script takes a raw data set and creates a tidy data set from it.

The raw data set is downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following steps are performed to create the tidy data set:
1. Check for a pre-downloaded copy of the raw data set, and if not found, download and unzip it.
2. Merging the training and the test sets to create one data set (See MergeData())
  1. Combines subject_test, y_test, X_test (in order)
  2. Combines subject_train, y_train, X_train (in order)
  3. Appends the combined "train" set to the combined "test" set
3. Extract the mean and standard deviation variables, along with the Subject and Activity variables (See ExtractMeanAndStd(...))
    This uses the names in features.txt, with only names with "mean()" and "std()" being used (see CodeBook.md)
4. The Activity (factor) variable is rebased to use descriptive activity names (See DescribeActivities(...)).
    Activity names are taken from activity_labels.txt, lowercased and with underscores replaced with spaces
5. Variables in the merged data set are named (See LabelData(...))
    Names are taken from features.txt. Abbreviations are expanded, hyphens and brackets are removed, and CamelCase is used to improve readability due to the long names.
6. Finally, a second data set is created with the average of each variable for each activity and each subject. 
    This table is exported to a text file using write.table()

#### Dependencies
This script requires the "dplyr" package. The script will check for this dependency and install and load it if not present.

#### Reading the final data
The final, averaged data can be read back into R with the following code:
```data <- read.table("./data/tidy.txt", header=TRUE)
View(data)
```
Note: this assumes the working directory has been set to the folder containing the "data" folder. 
Source: https://class.coursera.org/getdata-008/forum/thread?thread_id=24

### CodeBook.md
This file describes the summary choices made and details about each variable in the final data set (i.e. in tidy.txt)