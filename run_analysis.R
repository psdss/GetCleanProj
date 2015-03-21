# This R script implements the requirements of the course project for the 
# Getting and Cleaning Data Courseas outlined in the project requirements:
#
# 	1. Merges the training and the test sets to create one data set.
# 	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 	3. Uses descriptive activity names to name the activities in the data set
# 	4. Appropriately labels the data set with descriptive variable names. 
# 	5. From the data set in step 4, creates a second, independent tidy data set with 
# 	   the average of each variable for each activity and each subject.
#
#
# The data is available at 
#	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# 	and a full description of the data is available at
# 	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#
# Run this script with source("run_analysis.R") including any required path.
# Outputs include the files "cleaned_and_merged_data.txt" and "data_with_averages.txt".
#	To view the data you can use
#		data <- read.table("data_with_averages.txt") 
#
# The end result is a second, independent tidy data set with the average of
# each variable for each activity and each subject.
#


# 1. Merges the training and the test sets to create one data set.

xTrain <- read.table("train/X_train.txt")
xTest <- read.table("test/X_test.txt")
X_Data <- rbind(xTrain, xTest)

sTrain <- read.table("train/subject_train.txt")
sTest <- read.table("test/subject_test.txt")
Subject_Data <- rbind(sTrain, sTest)

yTrain <- read.table("train/y_train.txt")
yTest <- read.table("test/y_test.txt")
Y_Data <- rbind(yTrain, yTest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

allFeatures <- read.table("features.txt")
goodFeatures <- grep("-mean\\(\\)|-std\\(\\)", allFeatures[, 2])
X_Data <- X_Data[, goodFeatures]
names(X_Data) <- allFeatures[goodFeatures, 2]
names(X_Data) <- gsub("\\(|\\)", "", names(X_Data))
names(X_Data) <- tolower(names(X_Data))

# 3. Uses descriptive activity names to name the activities in the data set

activitiesData <- read.table("activity_labels.txt")
activitiesData[, 2] = gsub("_", "", tolower(as.character(activitiesData[, 2])))
Y_Data[,1] = activitiesData[Y_Data[,1], 2]
names(Y_Data) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names. 

names(Subject_Data) <- "subject"
mergedCleanedData <- cbind(Subject_Data, Y_Data, X_Data)
write.table(mergedCleanedData, "cleaned_and_merged_data.txt")

# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

uniqueSubjects = unique(Subject_Data)[,1]
numberOfSubjects = length(unique(Subject_Data)[,1])
numberOfActivities = length(activitiesData[,1])
numberOfColumns = dim(mergedCleanedData)[2]
cleanData = mergedCleanedData[1:(numberOfSubjects*numberOfActivities), ]

rowIndex = 1
for (subjectIndex in 1:numberOfSubjects) {
    for (activityIndex in 1:numberOfActivities) {
        cleanData[rowIndex, 1] = uniqueSubjects[subjectIndex]
        cleanData[rowIndex, 2] = activitiesData[activityIndex, 2]
        tmp <- mergedCleanedData[mergedCleanedData$subject==subjectIndex & mergedCleanedData$activity==activitiesData[activityIndex, 2], ]
        cleanData[rowIndex, 3:numberOfColumns] <- colMeans(tmp[, 3:numberOfColumns])
        rowIndex = rowIndex+1
    }
}
write.table(cleanData, "data_with_averages.txt")
