# Author: Peter May

#############################################
# Variables
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datadir <- "./data"
destfile <- paste(datadir,"uci_har_dataset.zip", sep="/")
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

ExtractMeanStd <- function(data){
  # Extracts the means and standard deviations for each measurement that
  # include "mean()" or "std()" in its feature name
  # Args: data
  #   The data set to extract the means and std columns from
  # Returns:
  #   The reduced data set including only mean and std columns
  features <- read.table("./data/UCI HAR Dataset/features.txt")
  indexes <- grep("(mean|std)\\(\\)", features$V2)
  
  reduced <- data[, indexes+2]    # +2 to ignore first 2 columns
  return (reduced)
}

#############################################
## Process Raw data
PkgInstall("data.table")

DownloadRaw()                     # Download raw data
merged <- MergeData()             # Merge the data
merged <- ExtractMeanStd(merged)  # Extract means and std
