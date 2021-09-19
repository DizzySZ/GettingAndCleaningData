temp <- tempfile()
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataURL, temp)
data <- unzip(temp,exdir = ".")
unlink(temp)

library(data.table)
activity_labels <- read.delim("./UCI Har Dataset/activity_labels.txt", sep = " ",
                              header = FALSE)
features <- read.delim("./UCI Har Dataset/features.txt", sep= " ",
                       header = FALSE)

list_of_training_files <- list.files(path = "./UCI HAR Dataset/train",
                                     pattern = ".txt$", 
                                     full.names = TRUE)
list_of_testing_files <- list.files(path = "./UCI HAR Dataset/test",
                                    pattern = ".txt$", 
                                    full.names = TRUE)


#creates list of dataframes for training and test datasets
# in order: subject test; X_test (data); Y_test (activity labels)
list_test_dataframe <- rbind(sapply(list_of_testing_files, fread, simplify = FALSE))
list_train_dataframe <- rbind(sapply(list_of_training_files, fread, simplify = FALSE))

#combine with ID and Activity labels
test_df <- cbind(list_test_dataframe[[1]], list_test_dataframe[[3]], list_test_dataframe[[2]])
train_df <- cbind(list_train_dataframe[[1]], list_train_dataframe[[3]], list_train_dataframe[[2]])


#rename columns of both data sets
colnames(test_df) <- c("ID", "Activity", features$V2)
colnames(train_df) <- c("ID", "Activity", features$V2)

# merge training and test set to create 1 dataset
combined_df <- rbind(test_df,train_df)

#Extract only mean and standard deviation for each measurement

#search through features for column numbers where contain mean or sd and extracts only those
# asked for the mean of each measurement which I have understood to be instances that have used
# the mean and std functions (noted as "mean()" and "std()" in the variable names)
meansd_col <- sort(c(grep("mean()", features$V2, fixed = TRUE), grep("std()", features$V2, fixed = TRUE)))
#modify column numbers to account for ID and Activity
meansd_col <- c(1, 2, meansd_col+2)

#select for means/std columns into new data frame and name columns.
meansd_df <- combined_df[,..meansd_col]



#rename activities in dataset (descriptive names such as Walking and WalkingUp
#get and replace activity number with the activity name)
for (obs in 1:nrow(meansd_df)){
  for (index in 1:nrow(activity_labels)){
    if (meansd_df$Activity[obs] == index){
      meansd_df$Activity[obs] <- tolower(activity_labels$V2[index])
    }
  }
}

#re-label data set variables
varName <-  gsub("^t", "Time.", names(meansd_df))
varName <-  gsub("^f", "Freq.", varName)
varName <-  gsub("mean()-", ".Mean.", varName, fixed = TRUE)
varName <-  gsub("std()-", ".SD.", varName, fixed = TRUE)
varName <-  gsub("mean()", ".Mean", varName, fixed = TRUE)
varName <-  gsub("std()", ".SD", varName, fixed = TRUE)
varName <-  gsub("BodyBody", "Body", varName, fixed = TRUE) #fixes typo of BodyBody
varName <-  gsub("-","", varName)

colnames(meansd_df) <- varName


#Create second independent tidy data set with average of each variable for each activity and subject.

df <- data.frame()
for (subject in 1:30){ #for each subject
  for (activity in tolower(activity_labels$V2)){ #for each activity
    data <- meansd_df[meansd_df$ID == subject & meansd_df$Activity == activity][,c(-1,-2)]
    subj_mean <- c(subject, activity, colMeans(data))
    df <- rbind(df,subj_mean)
  }
}
colnames(df) <- varName

#use write.table to export data frame into "finaldata.txt" file
write.table(df, file="finaldata.txt", row.names = FALSE)
