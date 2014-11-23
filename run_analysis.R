#run_analysis.R script that creates a tidy data set
# Coursera Course Project for 'Getting and Cleaning Data' class
# data description here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# data location here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# steps in the process:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#**************************************
#Pre-requsite to running the process
# 1) download the data and unzip to your working directory
#   this script assumes the folder 'UCI HAR Dataset' exists in your working directory
# 2) the following R packages are installed: "reshape2"

#load packages
library(reshape2)
##Load the data
curr_dir <- getwd()
#train
x_train <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/train/X_train.txt",sep=""),header=F)
y_train <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/train/y_train.txt",sep=""),header=F)
subj_train <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/train/subject_train.txt",sep=""),header=F)
#test
x_test <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/test/X_test.txt",sep=""),header=F)
y_test <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/test/y_test.txt",sep=""),header=F)
subj_test <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/test/subject_test.txt",sep=""),header=F)
#feature names
featurenames <- read.table(file=paste(curr_dir,"/UCI HAR Dataset/features.txt",sep=""),header=F,stringsAsFactors=F)

# STEP (1) Merge the training and test data sets into one data set
alldata <- rbind(cbind(y_train,subj_train,x_train),cbind(y_test,subj_test,x_test))
#rename columns
names(alldata) <- c("Activity", "SubjectID", featurenames$V2) 

# STEP (2) Extract only the measurements on the mean and standard deviation
#find mean and std variables 
idx <- c(1,2,grep("mean\\(\\)|std\\(\\)", names(alldata)))
subdata <- alldata[,idx]

# STEP (3) Use descriptive names to name the activites
subdata$Activity <- factor(subdata$Activity,labels=c("WALKING","WALKING_UPSTAIRS",
                                                  "WALKING_DOWNSTAIRS","SITTING",
                                                  "STANDING","LAYING"))

# STEP (4) Label the variable names appropriately
newnames <- names(subdata)
#replace dashes with dots
newnames <- gsub("-",".",newnames)
#replace () with a nothing
newnames <- gsub("\\(\\)","",newnames)
#replace t with time. and f with freq.
for (ii in 1:length(newnames))
{
    switch(substring(newnames[ii],1,1),
           "t"={newnames[ii] <- sub("t","time.",newnames[ii])},
           "f"={newnames[ii] <- sub("f","freq.",newnames[ii])})
}
#set names
names(subdata) <- newnames

# STEP (5) Create tidy data set with average of each variable for each activity and each subject
#melt data
subdatamelt <- melt(subdata,id.vars=c("Activity","SubjectID"))
#create tidy data with dcast and mean
tidydata <- dcast(subdatamelt, Activity + SubjectID ~ variable, mean)
#write data set
write.table(tidydata,file="tidydata.txt",row.names=F)

