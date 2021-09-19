# GettingAndCleaningData
For Coursera's Getting and Cleaning Data final assignment


This repository contains 4 files aside from this README document:


1. **UCI HAR Data set**
2. **run_analysis.R:** this R script processes the data to extract only the variables that are the means or standard deviations. Then the script calculates the mean of each extracted variable, according to participant and activity type.
3. **Codebook.md:** this markdown document explains all the variables in the finaldata text file.
4. **finaldata.txt:** this text file contains the final tidy data set of the average of all means and standard deviations for each participant and activity.


## 1. UCI HAR Dataset
This folder contains all the data that have been used in analyses. These data came from an experiment conducted on 30 participants aged between 19-48 years old. Each participant wore a smartphone at their waist and completed six activities (walking, walking upstairs, walking downstairs, sitting, standing or laying down). The data were all from the phone's gyrometer and accelerometer. The dataset were randomly separated into a "testing" (30% of data) and "training" (70% of data) data sets.

The main folder contains two text files:


1. *activity_labels.txt:* gives the coding for each activity type (e.g., 1 in the data set represents walking)
2. *features.txt:* gives the coding for each of the variables (columns) measured

Within each "test" and "train" folder, there are three files:


1. *subject_test.txt* and *subject_train.txt*: the participant ID for each observation
2. *X_test.txt* and *X_train.txt*: the values for each of the 561 variables
3. *Y_test.txt* and *Y_train.txt*: the activity type for each observation.


For more information about the data, please refer to:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## 2. run_analysis.R
This R script creates a new data frame of the average of the mean and standard deviation variables from the UCI HAR data set, organised by activity type and participant number.

Firstly, the script imports the data to combine the data from each of the three text files within the train and test folders so that each training and test dataset has the observations, participant ID and activity type together. Then the test and training data sets are merged into one data frame. Column names are then searched to only extract variables that are the mean and standard deviation for each measure.

The assignment requires us to extract the mean and standard deviation for each measurement. As there were multiple types of means within the original data set, for clarity, I have only extracted variables that have used the mean and std functions in R. These variables were marked with "mean()" or "std()" in the variable names.

The merged data set is organised in long-format so that rows are observations and columns are the variables. "ID" (participant ID) is the first column, followed by "Activity", labeling the activity type and then all the mean and standard deviations of measures.

The original data set had activity types represented as a number from 1 to 6. Lines 54 to 60 in the run_analysis code re-assigns the text label to each of the rows in the Activity column. 

The column names of this new, extracted data frame are then relabeled to improve clarity. Please see Codebook.md for more information on this step and how variables are named.

Lines 77 to 84 calculates the mean of each variable for each activity and each participant and appends it to a new data frame ("df"). Following tidy data principles, long and wide form data are both considered tidy as there is still only one observation per row (long data) or column (wide data). Therefore, in df, data are organised so each row represents the means for each participant and each activity whilst columns are the variables. 

Line 85 renames each of the columns to clearer names.

Finally, this dataframe is exported into a text file.

## 3. Codebook.md
This Markdown document outlines all the variables in the final data set and their definitions as well as the data type and values.


## 4. finaldata.txt
This text file contains the final tidy data set to be imported
