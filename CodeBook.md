CodeBook.md

gcdata_courseproject
====================

Repository for Getting and Cleaning Data Course Project

This repository contains the R script "run_analysis.R".  This script 
imports Smartphone data used for Human Activity Recoginition and creates
a tidy data set.

data description here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
data location here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

See the README.txt file in the dataset for more detailed information.

Summary:  The raw data is accelerometer and gyroscope data collected from 30 subjects doing 6 different human activities:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

The rawdata includes the following for each record:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The assignment is to create a tidy data set that has the average for each variable (measurements for mean and std) for each activity for each subject

Codebook:
The test and training data were combined to form one data set with the Activity, the SubjectID, and 561 features specified for each observation
The data was subsetting for features that took mean() or std() of the measurements
The Activity variable was transformed to a factor with the labels reflecting the names of the activities (listed above)
The feature names were made more readable by replacing dashes with dots and dropping the parenthesis after mean and std.  In addition the t or f prefix was replaced with time. or freq. to denote the measurement domain.  here are the resulting column names:
 [1] "Activity"                      "SubjectID"                    
 [3] "time.BodyAcc.mean.X"           "time.BodyAcc.mean.Y"          
 [5] "time.BodyAcc.mean.Z"           "time.BodyAcc.std.X"           
 [7] "time.BodyAcc.std.Y"            "time.BodyAcc.std.Z"           
 [9] "time.GravityAcc.mean.X"        "time.GravityAcc.mean.Y"       
[11] "time.GravityAcc.mean.Z"        "time.GravityAcc.std.X"        
[13] "time.GravityAcc.std.Y"         "time.GravityAcc.std.Z"        
[15] "time.BodyAccJerk.mean.X"       "time.BodyAccJerk.mean.Y"      
[17] "time.BodyAccJerk.mean.Z"       "time.BodyAccJerk.std.X"       
[19] "time.BodyAccJerk.std.Y"        "time.BodyAccJerk.std.Z"       
[21] "time.BodyGyro.mean.X"          "time.BodyGyro.mean.Y"         
[23] "time.BodyGyro.mean.Z"          "time.BodyGyro.std.X"          
[25] "time.BodyGyro.std.Y"           "time.BodyGyro.std.Z"          
[27] "time.BodyGyroJerk.mean.X"      "time.BodyGyroJerk.mean.Y"     
[29] "time.BodyGyroJerk.mean.Z"      "time.BodyGyroJerk.std.X"      
[31] "time.BodyGyroJerk.std.Y"       "time.BodyGyroJerk.std.Z"      
[33] "time.BodyAccMag.mean"          "time.BodyAccMag.std"          
[35] "time.GravityAccMag.mean"       "time.GravityAccMag.std"       
[37] "time.BodyAccJerkMag.mean"      "time.BodyAccJerkMag.std"      
[39] "time.BodyGyroMag.mean"         "time.BodyGyroMag.std"         
[41] "time.BodyGyroJerkMag.mean"     "time.BodyGyroJerkMag.std"     
[43] "freq.BodyAcc.mean.X"           "freq.BodyAcc.mean.Y"          
[45] "freq.BodyAcc.mean.Z"           "freq.BodyAcc.std.X"           
[47] "freq.BodyAcc.std.Y"            "freq.BodyAcc.std.Z"           
[49] "freq.BodyAccJerk.mean.X"       "freq.BodyAccJerk.mean.Y"      
[51] "freq.BodyAccJerk.mean.Z"       "freq.BodyAccJerk.std.X"       
[53] "freq.BodyAccJerk.std.Y"        "freq.BodyAccJerk.std.Z"       
[55] "freq.BodyGyro.mean.X"          "freq.BodyGyro.mean.Y"         
[57] "freq.BodyGyro.mean.Z"          "freq.BodyGyro.std.X"          
[59] "freq.BodyGyro.std.Y"           "freq.BodyGyro.std.Z"          
[61] "freq.BodyAccMag.mean"          "freq.BodyAccMag.std"          
[63] "freq.BodyBodyAccJerkMag.mean"  "freq.BodyBodyAccJerkMag.std"  
[65] "freq.BodyBodyGyroMag.mean"     "freq.BodyBodyGyroMag.std"     
[67] "freq.BodyBodyGyroJerkMag.mean" "freq.BodyBodyGyroJerkMag.std" 

The subsequent dataframe was melted and casted to form the tidy dataset using the melt and dcast functions to form a dataframe with 180 observations (6 activities x 30 subjects) and 68 columns reflecting the activity+subjectid + the average of the 66 measured variables
