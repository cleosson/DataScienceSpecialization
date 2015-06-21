# Getting and Cleaning Data - peer assessment project

## Environment info

R version 3.1.3 (2015-03-09)

Platform: x86_64-apple-darwin13.4.0 (64-bit)

Running under: OS X 10.10.3 (Yosemite)

## Info about the data and functions

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project: 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](ttps://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

In the run_analysis.R script, functions were created for each step.

Function pre_setting :
This function downloads and extracts the data from the link above.
Only use this function if you do not have the data in our machine

Function read_data :
This function is used to read the test or train data into the R environment. It does: 

* gets activities labels
* gets the activities
* gets the subject id
* gets the measures with correct column names
* selects only the mean and standard deviation measures
* creates a data frame with activities name, subject id and the measures

Function merge_data :
This function is used to merge the test and train data

Function tidy_data:
This function creates a tidy data set with average of each variable for each activity and each subject. The tidy data is  saved as text file to be submitted.

## How to

Executing the script from the R console:

> source("run_analysis.R")

To download the data, after source command run:

> pre_setting()

and then:

> tidy_data("tidy_data.txt")
