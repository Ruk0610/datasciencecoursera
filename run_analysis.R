# Librarys used

## data.table is effecient in handling larger data
library(data.table) 

## dplyr is used to aggregrate varibles and create tidy data
library(dplyr)

# Metadata
## In this data to support the metadata naming are given as the names of features are loaded into "FeaturesNames" and names of activities are loaded into "ActivityLables"

Features_Names <- read.table("UCI HAR Dataset/features.txt")
Activity_Lables <- read.table("UCI HAR Dataset/activity_lables.txt")

# Formating training and test datasets
#### Both training and test datasets are divided into three as subject, activity and features

## Training Data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
feature_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

## Test Data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
feature_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Part1. Merging the Traing and Test datasets to create only one dataset

## We can combine both datasets into subject, activity and feature

subject <- rbind(subject_test, subject_train)
activity <- rbind(activity_test, activity_train)
feature <- rbind(feature_test, feature_train)

## Naming the columns

colnames(feature)<-t(Features_Names[2])

# Merging the data

##The data in the feature, subject and activity are merged into a single completedata which is stored in the "CompleteData".

colnames(subject)<-"subject"
colnames(activity)<-"activity"

CompleteData <- cbind(feature, activity, subject)

# Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

## Extracting the column indices that are having either the Mean or Standard Deviation(STD)

Column_with_Mean_STD <- grep(".*Mean.*|.*Std.*", names(CompleteData), ignore.case = TRUE)

## Adding activity and subject column to list and have a look at the dimenssion of the "CompleteData"

Requiredcolumns <- c(Column_with_Mean_STD, 562, 563)
dim(CompleteData)

[1] 10299   563

## creating an extracteddata with the selected columns in the Requiredcolumns and have a look at the dimessions of the extratctedData

ExtractedData <- CompleteData[,Requiredcolumns]
dim(ExtractedData)

[1] 10299    88

# Part 3 - Uses descriptive activity names to name the activities in the data set

## we need to change the numeric type of Activity field in ExtractedData to character type. such that it can accept the activity names are accepted from the metadata "ActivityLable"

ExtractedData$activity <- as.character(ExtractedData$activity)
for (i in 1:6) {
ExtractedData$activity[ExtractedData$activity == i] <- as.character(Activity_Lables[i,2])  
}

## we need to factor the Activity_Lable variables, once the activity_lables names are updated

ExtractedData$activity <- as.character(ExtractedData$activity)

# Part 4 - Appropriately labels the data set with descriptive variable names

##Following are the names of the variables in the ExtractedData

names(ExtractedData)

[1] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                   
[3] "tBodyAcc-mean()-Z"                    "tBodyAcc-std()-X"                    
[5] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
[7] "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                
[9] "tGravityAcc-mean()-Z"                 "tGravityAcc-std()-X"                 
[11] "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                 
[13] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
[15] "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"                
[17] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
[19] "tBodyGyro-mean()-X"                   "tBodyGyro-mean()-Y"                  
[21] "tBodyGyro-mean()-Z"                   "tBodyGyro-std()-X"                   
[23] "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                   
[25] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
[27] "tBodyGyroJerk-mean()-Z"               "tBodyGyroJerk-std()-X"               
[29] "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[31] "tBodyAccMag-mean()"                   "tBodyAccMag-std()"                   
[33] "tGravityAccMag-mean()"                "tGravityAccMag-std()"                
[35] "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"               
[37] "tBodyGyroMag-mean()"                  "tBodyGyroMag-std()"                  
[39] "tBodyGyroJerkMag-mean()"              "tBodyGyroJerkMag-std()"              
[41] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[43] "fBodyAcc-mean()-Z"                    "fBodyAcc-std()-X"                    
[45] "fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"                    
[47] "fBodyAcc-meanFreq()-X"                "fBodyAcc-meanFreq()-Y"               
[49] "fBodyAcc-meanFreq()-Z"                "fBodyAccJerk-mean()-X"               
[51] "fBodyAccJerk-mean()-Y"                "fBodyAccJerk-mean()-Z"               
[53] "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                
[55] "fBodyAccJerk-std()-Z"                 "fBodyAccJerk-meanFreq()-X"           
[57] "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
[59] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
[61] "fBodyGyro-mean()-Z"                   "fBodyGyro-std()-X"                   
[63] "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                   
[65] "fBodyGyro-meanFreq()-X"               "fBodyGyro-meanFreq()-Y"              
[67] "fBodyGyro-meanFreq()-Z"               "fBodyAccMag-mean()"                  
[69] "fBodyAccMag-std()"                    "fBodyAccMag-meanFreq()"              
[71] "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-std()"           
[73] "fBodyBodyAccJerkMag-meanFreq()"       "fBodyBodyGyroMag-mean()"             
[75] "fBodyBodyGyroMag-std()"               "fBodyBodyGyroMag-meanFreq()"         
[77] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-std()"          
[79] "fBodyBodyGyroJerkMag-meanFreq()"      "angle(tBodyAccMean,gravity)"         
[81] "angle(tBodyAccJerkMean),gravityMean)" "angle(tBodyGyroMean,gravityMean)"    
[83] "angle(tBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)"                
[85] "angle(Y,gravityMean)"                 "angle(Z,gravityMean)"                
[87] "activity"                             "subject"  


## By examining the ExtractedData, we can say that following acronyms can be replaced:
##  Accelero can be replaced with Accelerometer
##  Gyro can be replaced with Gyroscope
##  BodyBody can be replaced with Body
##  Magni can be replaced with Magnitude
##  Character f can be replaced with Frequency
##  Character t can be replaced with Time

names(ExtractedData)<-gsub("Accelero", "Accelerometer", names(ExtractedData))
names(ExtractedData)<-gsub("Gyro", "Gyroscope", names(ExtractedData))
names(ExtractedData)<-gsub("BodyBody", "Body", names(ExtractedData))
names(ExtractedData)<-gsub("Magni", "Magnitude", names(ExtractedData))
names(ExtractedData)<-gsub("^t", "Time", names(ExtractedData))
names(ExtractedData)<-gsub("^f", "Frequency", names(ExtractedData))
names(ExtractedData)<-gsub("tBody", "TimeBody", names(ExtractedData))
names(ExtractedData)<-gsub("-mean()", "Mean", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("-std()", "STD", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("-freq()", "Frequency", names(ExtractedData), ignore.case = TRUE)
names(ExtractedData)<-gsub("angle", "Angle", names(ExtractedData))
names(ExtractedData)<-gsub("gravity", "Gravity", names(ExtractedData))

## Follwing are the names of the variables in the ExtractedData after they are modified.

names(ExtractedData)

[1] "TimeBodyAccMean()-X"                         
[2] "TimeBodyAccMean()-Y"                         
[3] "TimeBodyAccMean()-Z"                         
[4] "TimeBodyAccSTD()-X"                          
[5] "TimeBodyAccSTD()-Y"                          
[6] "TimeBodyAccSTD()-Z"                          
[7] "TimeGravityAccMean()-X"                      
[8] "TimeGravityAccMean()-Y"                      
[9] "TimeGravityAccMean()-Z"                      
[10] "TimeGravityAccSTD()-X"                       
[11] "TimeGravityAccSTD()-Y"                       
[12] "TimeGravityAccSTD()-Z"                       
[13] "TimeBodyAccJerkMean()-X"                     
[14] "TimeBodyAccJerkMean()-Y"                     
[15] "TimeBodyAccJerkMean()-Z"                     
[16] "TimeBodyAccJerkSTD()-X"                      
[17] "TimeBodyAccJerkSTD()-Y"                      
[18] "TimeBodyAccJerkSTD()-Z"                      
[19] "TimeBodyGyroscopeMean()-X"                   
[20] "TimeBodyGyroscopeMean()-Y"                   
[21] "TimeBodyGyroscopeMean()-Z"                   
[22] "TimeBodyGyroscopeSTD()-X"                    
[23] "TimeBodyGyroscopeSTD()-Y"                    
[24] "TimeBodyGyroscopeSTD()-Z"                    
[25] "TimeBodyGyroscopeJerkMean()-X"               
[26] "TimeBodyGyroscopeJerkMean()-Y"               
[27] "TimeBodyGyroscopeJerkMean()-Z"               
[28] "TimeBodyGyroscopeJerkSTD()-X"                
[29] "TimeBodyGyroscopeJerkSTD()-Y"                
[30] "TimeBodyGyroscopeJerkSTD()-Z"                
[31] "TimeBodyAccMagMean()"                        
[32] "TimeBodyAccMagSTD()"                         
[33] "TimeGravityAccMagMean()"                     
[34] "TimeGravityAccMagSTD()"                      
[35] "TimeBodyAccJerkMagMean()"                    
[36] "TimeBodyAccJerkMagSTD()"                     
[37] "TimeBodyGyroscopeMagMean()"                  
[38] "TimeBodyGyroscopeMagSTD()"                   
[39] "TimeBodyGyroscopeJerkMagMean()"              
[40] "TimeBodyGyroscopeJerkMagSTD()"               
[41] "FrequencyBodyAccMean()-X"                    
[42] "FrequencyBodyAccMean()-Y"                    
[43] "FrequencyBodyAccMean()-Z"                    
[44] "FrequencyBodyAccSTD()-X"                     
[45] "FrequencyBodyAccSTD()-Y"                     
[46] "FrequencyBodyAccSTD()-Z"                     
[47] "FrequencyBodyAccMeanFreq()-X"                
[48] "FrequencyBodyAccMeanFreq()-Y"                
[49] "FrequencyBodyAccMeanFreq()-Z"                
[50] "FrequencyBodyAccJerkMean()-X"                
[51] "FrequencyBodyAccJerkMean()-Y"                
[52] "FrequencyBodyAccJerkMean()-Z"                
[53] "FrequencyBodyAccJerkSTD()-X"                 
[54] "FrequencyBodyAccJerkSTD()-Y"                 
[55] "FrequencyBodyAccJerkSTD()-Z"                 
[56] "FrequencyBodyAccJerkMeanFreq()-X"            
[57] "FrequencyBodyAccJerkMeanFreq()-Y"            
[58] "FrequencyBodyAccJerkMeanFreq()-Z"            
[59] "FrequencyBodyGyroscopeMean()-X"              
[60] "FrequencyBodyGyroscopeMean()-Y"              
[61] "FrequencyBodyGyroscopeMean()-Z"              
[62] "FrequencyBodyGyroscopeSTD()-X"               
[63] "FrequencyBodyGyroscopeSTD()-Y"               
[64] "FrequencyBodyGyroscopeSTD()-Z"               
[65] "FrequencyBodyGyroscopeMeanFreq()-X"          
[66] "FrequencyBodyGyroscopeMeanFreq()-Y"          
[67] "FrequencyBodyGyroscopeMeanFreq()-Z"          
[68] "FrequencyBodyAccMagMean()"                   
[69] "FrequencyBodyAccMagSTD()"                    
[70] "FrequencyBodyAccMagMeanFreq()"               
[71] "FrequencyBodyAccJerkMagMean()"               
[72] "FrequencyBodyAccJerkMagSTD()"                
[73] "FrequencyBodyAccJerkMagMeanFreq()"           
[74] "FrequencyBodyGyroscopeMagMean()"             
[75] "FrequencyBodyGyroscopeMagSTD()"              
[76] "FrequencyBodyGyroscopeMagMeanFreq()"         
[77] "FrequencyBodyGyroscopeJerkMagMean()"         
[78] "FrequencyBodyGyroscopeJerkMagSTD()"          
[79] "FrequencyBodyGyroscopeJerkMagMeanFreq()"     
[80] "Angle(TimeBodyAccMean,Gravity)"              
[81] "Angle(TimeBodyAccJerkMean),GravityMean)"     
[82] "Angle(TimeBodyGyroscopeMean,GravityMean)"    
[83] "Angle(TimeBodyGyroscopeJerkMean,GravityMean)"
[84] "Angle(X,GravityMean)"                        
[85] "Angle(Y,GravityMean)"                        
[86] "Angle(Z,GravityMean)"                        
[87] "activity"                                    
[88] "subject"


# Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Let us set the subject as factor variable.

ExtractedData$subject <- as.factor(ExtractedData$subject)
ExtractedData <- data.table(ExtractedData)

# We create tidyData as a data set with average for each activity and subject. Then, we order the enties in tidyData wand write it into data file tidy.txt that contains the processed data.

tidyData <- aggregate(. ~subject + activity, ExtractedData, mean)
tidyData <- tidyData[order(tidyData$subject, tidyData$activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

