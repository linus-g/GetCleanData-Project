# This script imports a set of data files collected from accelerometers in smartphones,
# and processes the data into a tidy data set that can easily be used for analysis.
# It also merges a test and a training data set.
#
# Written in October 2014

library(tidyr)
library(dplyr)
        
#Set working directory to that containing folder with data files
setwd("C:/Users/linus/r_repos/GetCleanData-Project")

# Read in files containing variable names and activity labels data
activity_labels.df <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
features.df <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)

############# 1. Read in and merge data for test data set ##############

        # Read in files
        test.df <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
        test_activities.df <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
        test_subjects.df <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
        
        # Add subject and activity data to test data frame
        test.df <- cbind(test_subjects.df, test_activities.df, test.df)
         
        # Add variable names
        names(test.df) <- c("subject", "activity", as.character(features.df[,2]))
        
        # Remove data frames no longer required
        rm(test_subjects.df)
        rm(test_activities.df)

############# 2. Read in and merge data for train data set ##############

        # Read in files
        train.df <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
        train_activities.df <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
        train_subjects.df <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
        
        # Add subject and acitivity data to train data frame
        train.df <- cbind(train_subjects.df, train_activities.df, train.df)
        # Add variable names
        names(train.df) <- c("subject", "activity", as.character(features.df[,2]))
        
        # Remove data frames no longer required
        rm(train_subjects.df) 
        rm(train_activities.df)
        
        # Remove features.df as no longer needed
        rm(features.df)

###### 3. Merge test and training data sets and tidy up #################

        # Merge test and train data set, and remove non-merged data frames
        data.df <- rbind(test.df, train.df)
        rm(test.df)
        rm(train.df)
        
        # Create a dplyr data table and remove data frame
        data.tbl <- tbl_df(data.df)
        rm(data.df)
        
        # Get vector of column numbers with variable names that contains "mean()" or "std()" (excluding FreqMean)
        varColumns <- c(grep("mean()", names(data.tbl), fixed=TRUE), grep("std()", names(data.tbl), fixed=TRUE))
        
        # Subset data to only include variables we want, remove vector containing col numbers
        data.tbl <- select(data.tbl, c(activity,subject,varColumns))
        rm(varColumns)
        
        # Replace activity number with descriptive activity name
        # Because the number in activity corresponds to the row in activity_labels.df
        # we can simply subset column 2 of activity_labels.df by the numbers in activity
        data.tbl$activity <- activity_labels.df[data.tbl$activity,2]
        rm(activity_labels.df)
        
        # Fix variable names to neater format 
        # lowercase, remove non-alphanumerical characters
        # change t to time, change f to fourier, std to stdev
        colNames <- names(data.tbl)
        colNames <- gsub("()", "", colNames, fixed=TRUE)
        colNames <- tolower(colNames)
        colNames <- gsub("-", "", colNames, fixed=TRUE)
        colNames <- sub(pattern="^t", replacement="time", colNames)
        colNames <- sub(pattern="^f", replacement="fourier", colNames)
        colNames <- sub(pattern="std", replacement="stdev", colNames)
        
        # Add tidy names to data frame, remove vector with tidy names no longer needed
        names(data.tbl) <- colNames
        rm(colNames)
        
        # Change subject variable into factor
        data.tbl$subject <- as.factor(data.tbl$subject)

############## 4. Analyse data and save output ########################
        
        # Summarise each variable by subject and activity (using dplyr functions)
        data_summary.tbl <-  group_by(data.tbl, subject, activity) %>%
            summarise_each(funs(mean))
        
        # Write output file
        write.table(data_summary.tbl, "datasummary.txt", row.name=FALSE)
