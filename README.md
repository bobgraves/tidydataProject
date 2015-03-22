# README.md
### Prepared by: Bob Graves
### Getting and Cleaning Data, Coursera, March 2015

# Overview
Perform data loading and manipulation of a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. The output is a tidy data set of results.

# Project Requirements
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates an independent tidy data set with the average of each variable for each activity and each subject.
- Save tidy data to text output file

# Code Approach
Following is the step-by-step code approach for the project. Please refer to the CodeBook.md for the list of
variable names.

- Setup - Read Feature names and convert them into R-compatible, descriptive variable names
to be used as column headers for the test and training data
- Read the Test data tables, with descriptive variable names assigned to each column
- Read the Training data tables, with descriptive variable names assigned to each column
- Read the activity labels 
- Determine which columns are relevant for the analysis (i.e. means and standard deviation terms)
- Use name matching of the readable columns to figure out which have the term "mean" or "std"
- Combine (or) the means and std to figure out the total list of relevant columns 
- Extract only the relevant columns (means and std-s) from test data
- Add the subject and activity factor to the test data, keeping nice names for columns
- Post-condition for columns

* col1 = subject id
* col2 = Activity
* col3-88 = mean, std terms

- Extract only the relevant columns (means and std-s) from training data
- Add the subject and activity factor to the test data, keeping nice names for columns
- Combine the data sets
- Compute the average of each term (means and standard deviations) for each subject and activity,
forming the data in the tidy data frame
- Augment the column names in the tidydata data frame, since now each column represents 
the mean of the mean or std deviation. To avoid confusion, we use the descriptive 
term "Average" as a prefix for each column
- Save the tidy data to an output text file for uploading to Coursera site

# File List
- UCI HAR Dataset - file set, described below.
- tidydata.txt - output data for project
- CodeBook.md - detailed description of project R code and variables

# UCI HAR Dataset
(Information repeated here for consistency)

The input data for this project comes from the UCI HAR Dataset. 

- Precondition - UCI HAR Dataset unzipped in local directory
- All files are in the immediate subdirectory of the working directory (typical unzip to dir)


Attribute Information:

For each record in the dataset it is provided (X data)

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. (Y data)
- An identifier of the subject who carried out the experiment. (Subject data)

# References
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Citation
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.


