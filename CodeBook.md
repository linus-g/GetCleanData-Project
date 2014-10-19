
CodeBook
=================

Data set description
-----------------

This codebook describes the data set in datasummary.txt, produced by the run_analysis.R script.

Each line in the file contains one observation, and the file can be read by R using the following code:

df <- read.table("datasummary.txt", header=TRUE)

This data set contains smartphone accelerometer and gyroscope measurements from 30 subjects performing activities of daily living. During measurement, the subjects were carrying a waist-mounted smartphone with embedded inertial sensors.

The original data is the Human Activity Recognition Using Smartphones Data Set from the UCI Machine Learning Repository. Much of the information below was taken from the 'features.txt' document provided with the original data set.

The original data set can be found on the following page:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Feature Selection 
-----------------

The data set contains the following variables and group of variables:

**subject**

This variable ranges from 1 to 30, and indicates which of subjects the observations refers to.

**activity**

This variables indicates which type of activity the subject performed while the measurement was taken. The possible values are:

- STANDING         
- SITTING            
- LAYING             
- WALKING            
- WALKING_DOWNSTAIRS
- WALKING_UPSTAIRS 

**Measurement variables**

The remaining variables contains the measurements from the accelerometers and gyroscopes. This data set contains the average value for the mean and standard deviation for each activity and subject. Note that the in the original data set, all features are normalized and bounded within [-1,1].

This is the description from the **original** data set:

*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.* 

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).* 

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).* 

*These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.*

**Transformations**

From the original data set, the mean and standard deviation for each feature and observation were extracted. The mean of these were then calculated for each type of activity and subject. For example, an observation can be interpreted as the average body x-direction acceleration (timebodyaccmeanx) for subject 1 for all the times the subject was sitting down. Note that all variables presented are averages across all the times a subject performed that activity.

The variable names have been modified from the original to make them more readable:

- all variable names were converted to lower case
- all non-alphanumerical characters were removed
- 't' was expanded to 'time'
- 'f' was expanded to 'fourier'
- 'std' was expanded to stdev

