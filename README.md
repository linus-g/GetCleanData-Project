Getting and Cleaning Data - Course Project
====================

This project is made up of the following files:

- datasummary.txt
- run_analysis.R
- CodeBook.md

1. The datasummary.txt contains the tidy data for this project. It can be imported into R using the following code:

df <- read.table("datasummary.txt", header=TRUE)

2. The run_analysis.R script performs all the data processing needed for this project. It imports all data, merges the test and training data sets, and processes it into a tidy data set. The output from the script is a text file called 'datasummary.txt', containing the average value of each variable in the data set, by activity and subject.

Before running the script, the data needs to be downloaded from the URL below and unzipped. The working directory needs to be set to the folder containing the folder from the unzipped archive.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The run_analysis.R does the following processing of the original data files:

- For each of the data sets (test and train) it reads in the following files:
- X_'dataset'.txt containing the measuremen variables
- y_train.txt containing the activity type ID for each measurement
- subject_train.txt containing the subject ID for each measurement

For each data set the information in the three files are merged into a single data set. The script then merged the test and training data sets.

A subset of the data set is created that only contains variables relating the mean or standard deviation of each type of measurement.

The activity ID numbers are replaced with descriptive (such as WALKING and SITTING) names from the 'activity_labels.txt' file.

The variable names from the 'features.txt' file are cleaned up and added to the data file. 

Finally, the script calculates the mean for each variable by activity and subject in a tidy data set and saves it as datasummary.txt.

That the data set is tidy here refers the following qualities (see paper by Hadley Wickham http://vita.had.co.nz/papers/tidy-data.pdf):

- Each variable forms a column.
- Each observation forms a row.
- Each type of observational unit forms a table.

The data is organised in a wide form, which implies that an on observation is considered to be made up of the set of all measures for that observation. Each feature is therefore its own variable in the column.

3. The CodeBook.md markdown file describes the data set and the variables in the data set produced by the run_analysis.R script.
