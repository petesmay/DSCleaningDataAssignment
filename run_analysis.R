# Author: Peter May

#############################################
# Variables
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datadir <- "./data"
destfile <- paste(datadir, "uci_har_dataset.zip", sep="/")
tidyfile <- paste(datadir, "tidy.txt", sep="/")
#############################################

PkgInstall <- function(pkg){
  # Loads the specified package, installing it if its not already.
  # Courtesy of http://stackoverflow.com/questions/9341635/how-can-i-check-for\
  # -installed-r-packages-before-running-install-packages
  # Args:
  #    The package to load, installing first where necessary
  # Returns: nothing
  if (!require(pkg, character.only=TRUE)){
    install.packages(pkg, dependencies=TRUE)
    if (!require(pkg, character.only=TRUE)){
      stop("Package not found")
    }
  }
}

DownloadRaw = function(){
  # If not already present, downloads the raw data and unzips it
  # Args: none
  # Returns: nothing

  # Check data directory exists, if not, create
  if (!file.exists(datadir)){
    dir.create(datadir)
  }
  
  ## Download data and unzip if we haven't done so already
  if (!file.exists(destfile)){
    download.file(fileurl, destfile=destfile)
    datedownloaded <- date()
    unzip(destfile, exdir=datadir)
  }
}

MergeData = function(){
  # Merges the test and training set
  # Args: none
  # Returns:
  #   The completely merged raw data set
  
  # Merge test data
  tst.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
  tst.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
  tst.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  
  tst.merged <- cbind(tst.subject, tst.y, tst.x)
  
  # Merge training data
  train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
  train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
  
  train.merged <- cbind(train.subject, train.y, train.x)
  
  # Merge the test and training data
  merged <- rbind(tst.merged, train.merged)
  return (merged)
}

GetMeanStdIndexes <- function(){
  # Returns the indexes of all rows from features.txt which include "mean()"
  # or "std()".
  # Args: none
  # Returns:
  #   An integer vector of row indexes from features.txt including "mean()" or
  #   "std()" in the feature label
  # Side effects:
  #   features is made globally available
  features <<- read.table("./data/UCI HAR Dataset/features.txt")
  indexes <- grep("(mean|std)\\(\\)", features$V2)
  return (indexes)
}

ExtractMeanAndStd <- function(data){
  # Extracts the means and standard deviations for each measurement that
  # include "mean()" or "std()" in its feature name. Names with "mean"
  # without the "()" are not included (see CodeBook.md for details).
  # The subject who performed the test, and the test type are also included
  # in the output data set.
  # Args: data
  #   The data set to extract the means and std columns from
  # Returns:
  #   The reduced data set including subject, test type, mean and std variables
  indexes <- GetMeanStdIndexes()
  indexes <- indexes+2          # Add 2 to each index to skip first 2 columns
  indexes <- c(1:2, indexes)    # subject; test type; mean|std variables
  
  reduced <- data[, indexes]    # subset only those columns
  return (reduced)
}

DescribeActivities <- function(data){
  # Replaces the test type (i.e. activity) with the associated label from
  # activity_labels.txt
  # Args: data
  #   The data set to operate over
  # Returns:
  #   The modified data set with test activity replaced with an appropriate
  #   label
  
  activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
  labels <- tolower(activities$V2)
  
  # remove "_"
  labels <- gsub("_", " ", labels)
  
  data$V1.1 <- as.factor(data$V1.1)  # turn the current types into a factor
  levels(data$V1.1) <- labels        # use label to rebase the factor
  
  return (data)
}

LabelData <- function(data){
  # Labels the variables appropriately from the names in the features.txt 
  # file.
  # Abbreviations are expanded out
  # Hyphens and brackets are removed.
  # CamelCase is used to improve readability in the long names
  # Args: data
  #   The data set to label
  # Returns:
  #   The CamelCase labelled data set
  
  # get the relevant labels from features.txt
  indexes <- GetMeanStdIndexes()
  colnames <- as.character(features[indexes, 2])
  
  # remove duplicate "Body", e.g. "fBodyBodyAccJerkMag"
  colnames <- sub("(fBody)Body", "\\1", colnames)
  # remove ()'s
  colnames <- sub("\\(\\)", "", colnames)
  # remove -'s
  colnames <- gsub("\\-", "", colnames)
  
  # expand "Acc" to "Acceleration"
  colnames <- sub("Acc", "Acceleration", colnames)
  # expand initial "t"s and "f"s to "Time" and "Frequency
  colnames <- sub("^t", "Time", colnames)
  colnames <- sub("^f", "Frequency", colnames)
  # "mean" is capitalised (for readability)
  colnames <- sub("mean", "Mean", colnames)
  # "std" is expanded to "StandardDeviation"
  colnames <- sub("std", "StandardDeviation", colnames)
  # "Gyro" is expanded to "Gyroscope"
  colnames <- sub("Gyro", "Gyroscope", colnames)
  # "Mag" is expanded to "Magnitude", colnames)
  colnames <- sub("Mag", "Magnitude", colnames)
  # Final "X", "Y", or "Z" is expanded to "XAxis" or similar
  colnames <- sub("([XYZ])$", "\\1Axis", colnames)
  
  # prepend Subject, Activity
  colnames <- c("Subject", "Activity", colnames)  
  
  # Finally set the names
  names(data) <- colnames
  return (data)
}

AverageVariables <- function(data){
  # Averages the specified data frame by "Subject" and "Activity".
  # Args: data
  #   The data to average
  # Returns:
  #   A summary of the data grouped by Subject and Activity
  
  ## Approach 1: using group_by and summarise_each 
  # PkgInstall("dplyr")
  ## expects "Subject" and "Activity" variables
  #by.subjectactivity <- group_by(data, Subject, Activity)
  #
  #summarised <- summarise_each(by.subjectactivity, funs(mean))
  
  ## Approach 2: using melt and dcast
  PkgInstall("reshape2")
  measures <- names(data)[3:68]   # use the column headers as measures
  # Melt the data together
  melt.data <- melt(data, id=c("Subject", "Activity"), measure.vars=measures)
  # Use dcast to summarise the means by Subject and Activity
  summarised <- dcast(melt.data, Subject + Activity ~ variable, mean)
  
  return (summarised)
}

#############################################
## Process Raw data


DownloadRaw()                          # Download raw data
merged <- MergeData()                  # Step 1: Merge the data
merged <- ExtractMeanAndStd(merged)    # Step 2: Extract means and std
merged <- DescribeActivities(merged)   # Step 3: Use descriptive activity names
merged <- LabelData(merged)            # Step 4: Label variables
summarised <- AverageVariables(merged) # Step 5: Average each variable

# write to a text file
write.table(summarised, tidyfile, row.name=FALSE)