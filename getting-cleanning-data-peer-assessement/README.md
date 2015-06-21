# Getting and Cleaning Data - peer assessment project

##Base environment info

R version 3.1.3 (2015-03-09)

Platform: x86_64-apple-darwin13.4.0 (64-bit)

Running under: OS X 10.10.3 (Yosemite)

## Info about the data and functions

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In the run_analysis.R script, functions were created for each step.

Function pre_setting :
This function downloads and extract the data from the link above.
Only use this function if you do not have the data in our machine

Function read_data :
This function is used:
*to read the test or train data into the R environment

Function read_train_data :
This function is used to read the train data into the R environment

Function mergeDataset :
This function combines the two dataset read in the above functions, by rows.Further, proper name is given to the columns and dataset is returned.

Function activityLabels:
This function takes a dataset as argument and reads the activity labels from text files and merges it with the dataset.

Function merge_label_data :
This function runs the activityLabels function to get a activity labelled dataset.

Function tidyData:
This function creates a tidy data set with average of each variable for each activity and each subject.

Function tidy_datafile:
A new tidy independent dataset is generated and saved a text file to be submitted.
