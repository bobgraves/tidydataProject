# Bob Graves
# Coursera - Getting and Cleaning Data
# March 2015
# Project run_analysis.R

# Project requirements 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates an independent tidy data set with the average of each variable for each activity and each subject.
# Save tidy data to text output file

# precondition - UCI HAR Dataset unzipped in local directory
# all files are in the immediate subdirectory of the working directory (typical unzip to dir)

# Filenames used in this project

fnTest_X<-"UCI HAR Dataset/test/X_test.txt"
fnTest_Y<-"UCI HAR Dataset/test/y_test.txt"
fnTest_Subject<-"UCI HAR Dataset/test/subject_test.txt"

fnTrain_X<-"UCI HAR Dataset/train/X_train.txt"
fnTrain_Y<-"UCI HAR Dataset/train/y_train.txt"
fnTrain_Subject<-"UCI HAR Dataset/train/subject_train.txt"

fnFeatures<-"UCI HAR Dataset/features.txt"

fnActivity <-"UCI HAR Dataset/activity_labels.txt"

# Read raw data tables, assigning meaningful column names where possible.
# Combine subject and activity (Y) information into the "X" data frame

# Setup - Read Feature names and convert them into R-compatible, descriptive variable names
# to be used as column headers for the test and training data

features<-read.table(fnFeatures,header=FALSE)
features$feature<-gsub("[-,]","_",gsub("[)()]","",features$V2))

# Read the Test data tables, with descriptive variable names assigned to each column

test_x_data<-read.table(fnTest_X,header = FALSE,col.names=features$feature)
test_y_data<-read.table(fnTest_Y,header = FALSE,col.names=c("ActivityID"))
test_subject<-read.table(fnTest_Subject, header = FALSE,col.names = c("SubjectID"))

# verify data size
dim(test_x_data)

# Read the Training data tables, with descriptive variable names assigned to each column

train_x_data<-read.table(fnTrain_X,header = FALSE,col.names=features$feature)
train_y_data<-read.table(fnTrain_Y,header = FALSE,col.names=c("ActivityID"))
train_subject<-read.table(fnTrain_Subject, header = FALSE,col.names = c("SubjectID"))

# verify data size
dim(train_x_data)

# Read the activity labels 
activity_labels<-read.table(fnActivity,stringsAsFactors = FALSE,col.names = c("ActivityID","Activity"))

# debug 
# factor(test_y_data$ActivityID,labels=activity_labels$Activity)

# Determine which columns are relevant for the analysis (i.e. means and standard deviation terms)
# Use name matching of the readable columns to figure out which have the term "mean" or "std"
meanCols<-grepl(".*mean.*",features$V2,ignore.case = TRUE)
stdCols<-grepl(".*std.*",features$V2,ignore.case = TRUE)

# Combine (or) the means and std to figure out the total list of relevant columns 
bothCols<-meanCols | stdCols
numRelevantCols<-sum(bothCols)

# Extract only the relevant columns (means and std-s) from test data
test_x_cut<-test_x_data[,bothCols]

# Add the subject and activity factor to the test data, keeping nice names for columns
test_data<-cbind(test_subject,factor(test_y_data$ActivityID,labels=activity_labels$Activity),test_x_cut)
names(test_data)[2]<-"Activity"
# post-condition
# col1 = subject id
# col2 = Activity
# col3-88 = mean, std terms

# Extract only the relevant columns (means and std-s) from training data
train_x_cut<-train_x_data[,bothCols]

# Add the subject and activity factor to the test data, keeping nice names for columns
train_data<-cbind(train_subject,factor(train_y_data$ActivityID,labels=activity_labels$Activity),train_x_cut)
names(train_data)[2]<-"Activity"

#combine the data sets
data<-rbind(test_data,train_data)

#debug
#small_data<-test_data[1:1000,c(1,2,3,88)]
#aggregate(. ~ SubjectID + Activity, small_data, FUN=mean)

# compute the average of each term (means and standard deviations)
# for each subject and activity 
# This forms the data in the tidy data frame
tidydata<-aggregate(. ~ SubjectID + Activity, data, FUN=mean)

# Augment the column names in the tidydata data frame, since now each column represents 
# the mean of the mean or std deviation. To avoid confusion, we use the descriptive 
# term "Average" as a prefix for each column
names(tidydata)[3:88]<-paste("Average_",names(tidydata)[3:88],sep="")

# size
dim(tidydata)

# Save the tidy data to an output text file for uploading to Coursera site
fnOut<-"tidydata.txt"
write.table(tidydata,file = fnOut,row.name=FALSE)

# end
