
# Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!


# Getting Started

## Downloaded Data

Downloaded the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip file provided in the project assignment. Unzip the file.

# Setting the Working Directory to the Downloaded file


```python
setwd ("C:/Users/ravi/Desktop/Ruk Coursera/Getting and Cleaning Data/UCI HAR Dataset")
```

# Loading the required packages


```python
library(dplyr)
library(data.table)
library(tidry)
```

## Read supporting Metadata

The supporting metadata in this data are the name of the features and the name of the activities. They are loaded into variables FeaturesNames and Activitylables


```python
FeaturesNames <- read.table("./features.txt")
Activitylables <- read.table("./activity_labels.txt")
```

## Formatting training and test datasets

Both training and test data sets are split up into subject, activity and features. They are present in three different files.

## Read training data


```python
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
Activity_train <- read.table("./train/X_train.txt", header = FALSE)
Feature_train <- read.table("./train/y_train.txt", header = FALSE)
```

## Read test data


```python
subject_test <- read.table("./test/subject_test.txt", header = FALSE)
Activity_test <- read.table("./test/X_test.txt", header = FALSE)
Feature_test <- read.table("./test/y_test.txt", header = FALSE)
```

# Part 1 - Merge the training and the test sets to create one data set

We can use combine the respective data in training and test data sets corresponding to subject, activity and features. The results are stored in subject, activity and features.


```python
subject <- rbind(subject_train, subject_test)
Feature <- rbind(Feature_train, Feature_test)
Activity <- rbind(Activity_train, Activity_test)
```

## Naming the columns

The columns in the features data set can be named from the metadat in FeatureNames


```python
colnames(Feature) <- FeaturesNames$featureName
```

## Merge the data

The data in subject, Feature and Activity are merged and the complete data is stored in CompleteData


```python
ColNames(Activity) <- "Activity"
ColNames(subject) <- "subject"
CompleteData <- cbind(Feature, Activity, subject)
```

# Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

Extract the column indices that have either mean or standard deviation(std) in them.


```python
column_With_Mean_STD2 <- grep(".Mean.*|.*Std.*", names(CompleteData), ignore.case = TRUE) 
```

Add activity and subject to the list and look at the dimension of the CompleteData


```python
requiredCOlumns <- c(column_With_Mean_STD2, 562, 563)
```


```python
## [1] 10299 563
```

We careate ExtractData with the selected columns in requiredColumns and again we look at the dimension of requiredcolumns


```python
extractedData <- CompleteData[,requiredCOlumns]
dim(extractedData)
```


```python
## [1] 10299 88
```
