# Getting and Cleaning Smartphone Dataset
Peer-graded Assignment: Getting and Cleaning Data Course Project
The script ```run_analysis.R``` uses data from the UCI Machine Learning Repository.
Information on the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The user must download the following input files and place them in the working directory.

X_test.txt; X_train.txt; Y_test.txt; Y_train.txt; activity_labels.txt; features.txt

---------------------------------------
The script performs  3 main functions:
1) It merges the training and testing data
2) It selects only the variables representing the mean and standard deviation for each measurement
3) It redefines the activity variable from numeric (1:6) to character values that describe the activity
4) It renames the variable names to be more intuitive
5) It summarizes the selected variables by taking the mean by activty and by each subject, and exports that file as means.txt
