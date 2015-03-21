Getting and Cleaning Data
Course Project - README.MD

The code and documentation in this repository meet the requirements of the course project for the Getting and Cleaning Data Course.  As specified in the assignment, the data is described at "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" and should be downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".

The code can be tested as follows:

* Download and unzip the file specified above into a directory.

* Set the working directory to the directory "./UCI HAR Dataset".

* Put the source file "run_analysis.R" into the working directory.

* From within R or RStudio, execute the command source("run_analysis.R")


The output files are "cleaned_and_merged_data.txt" and "data_with_averages.txt".  The data is best viewed within RStudio with the commands:

* data <- read.table("data_with_averages.txt")

* View(data)
