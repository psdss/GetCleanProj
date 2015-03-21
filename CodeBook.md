# Getting and Cleaning Data
# Course Project - CodeBook.md


# Introduction

The code and documentation in this repository meet the requirements of the course project for the Getting and Cleaning Data Course. 

As specified in the assignment, the input data is described at "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" and should be downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".

The output files are "cleaned_and_merged_data.txt" and "data_with_averages.txt"; the latter containing the a second, independent tidy data set with the average of each variable for each activity and each subject.


# Overview of Processing

The code to implement the project requirements is in the file "run_analysis.R", processing as follows:


1. Merges the training and the test sets to create one data set.

Merges "train/X_train.txt" with "test/X_test.txt", "train/subject_train.txt" with "test/subject_test.txt", and "train/y_train.txt" with "test/y_test.txt".  The result is a 10299x561 dataframe.


2. Extracts only the measurements on the mean and standard deviation for each measurement.

Extracts all features with "-mean" or "-std" resulting in a 10299x66 dataframe. 


3. Uses descriptive activity names to name the activities in the data set

Reads from the activity_labels.txt file in the original zip to apply descriptive activity names.

	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING


4. Appropriately labels the data set with descriptive variable names. 

Remove parens "()" and hyphen "-" symbols in the column names.  Change the names to all lower case. Merge dataframe containing features with the dataframes containing activity labels and subject IDs. The result is written to "cleaned_and_merged_data.txt".


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The second dataset is stored in the file "data_with_averages.txt".  The result is 30 unique subjects and 6 unique activities, for a total of 180 combinations. The code calculates the mean of each measurement, so the result is a 180x68 data frame.


# Variables

* Downloaded data: XTrain, XTest, YTrain, YTest, STrain, STest
* Merged data: X_Data, Y_Data, Subject_Data
* Activities data: downloaded from "activity_labels.txt" into activitiesData
* Merged, Cleaned Data: mergedCleanedData
* Data with Averages: cleanData

