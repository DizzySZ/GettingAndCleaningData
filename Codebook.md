# Codebook

This is the codebook describing the variables in the finaldata.txt file. For an explanation of the data set, please refer to the README file.

## About finaldata.txt
finaldata.txt is a text file table that contains the average for each variable organised by each subject and each activity. Values are separated by a space.

You can import this file using the following code:
```
data <- read.delim("finaldata.txt", sep = " ") 
```
(Note: the code assumes that the text file is in your working directory)

The file contains 180 observations of (30 participants with 6 activities each) and 68 columns (participant number, activity type, and the average for each of the 66 variables). 

All columns are numeric data except for the "Activity" column, which is a character string.

## Variable (Column) naming convention 
Variables have been named using the following formatting, separated by a dot (".") and explanations of the key words are in the table below.


1. Whether it is time-based or frequency-based variable? (**Time** or **Freq**) and feature type:
  a. **Body** or **Gravity**?
  b. **Accelerometer** or **Gyroscope**?
  c. **Jerk** or not? 
  d. **Magnitude** or not? 
2. Whether it is the mean or standard deviation (**Mean** or **SD**)*
3. [If applicable] it's 3D axis (**X**, **Y** or **Z**) 

*Note: mean and standard deviations were treated as variables that used the mean() and std() functions (see README for an explanation)


| Key words/Variables   |Definition and units of measurement  |
| :------------- |:-----------------------------------|
| BodyAcc | This is one of two types of acceleration - body acceleration separated with a low-pass Butterworth filter with a frequency of 0.3Hz|
| Freq | Fast Fourier Transformed variables represented by frequency |
| GravityAcc | The other type of accerlation - gravitational acceleration separated with a low-pass Butterworth filter with a frequency of 0.3Hz |
| Gyro | Data based on the Gyrometer |
| Jerk | The Jerk of the phone when it is being moved |
| Mag | Magnitude of the jerk, calculated using the Euclidean norm |
| Time | Data sampled at a frequency of 50Hz and filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise |
| X | Data from the X axis |
| Y | Data from the Y axis |
| Z | Data from the Z axis |

For example, the Freq.BodyAcc.SD.X column contains the the mean of the standard deviations for the X-axis frequencies for body acceleration for each participant and each activity (activities are described below). 

## Data
**ID:** Participant ID number. This ranges from 1 to 30, for each of the 30 subjects in the data set. 

**Activity:** Activity name. This column describes the activity that was being done and there were six activities in total, as listed in the table below.

| Activity        |Definition  |
| :------------- |:-----|
| walking | Participants walked in a straight line |
| walking_upstairs | Participants walked up two flights of stairs |
| walking_downstairs | Participants walked down two flights of stairs |
| sitting | Participants sat in a chair |
| standing | Participants stood still in the lab |
| laying | Participants lay down on an elevated bed|
