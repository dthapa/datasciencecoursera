###Cookbook

Detailed information about the original dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
This cookbook scope will be only limited to describing the tidy data
obtained by running the recipe against the above data source.

###Course Assignment Instruction
You should create one R script called run_analysis.R that does the following.
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with 
  the average of each variable for each activity and each subject.

###Study Design
The original dataset contains study data for a wearable technology, where
participants were involved in various activities while wearing a mobile phone.
Various measurements were taken by the device's accelerometer and gyroscope sensors,
then cleaned and collected in the dataset where together with original features and 
composite features make a total of 561 features. 
Again, for more details visit the link provided above.

###Tidy data
The course project instructions were achieved by merging, filtering, and modifying various parts of the
dataset. As instructed, a single **run_analysis.R** file in the repo can be used to produce the tidy data sets.
Please see **README.md** for how to run. It's very simple with little dependency.

###Code book
Both the training and testing data set were merged to create one single tidy data set consisting of 57 features
from the 561 original features and are listed below - these features concern mean and standard deviation only.
In addition, subject.id and activity were later added to the dataset from other files, making a total of 59 features.
The tidy data generated adheres to the tidy data requirements as expressed in README.md
```
ID	Original.Feature.Name	    Descriptive.Feature.Name
--------------------------------------------------------------------------
1	tBodyAcc-mean()-X	        timedBodyAccelerationMean-X
2	tBodyAcc-mean()-Y	        timedBodyAccelerationMean-Y
3	tBodyAcc-mean()-Z	        timedBodyAccelerationMean-Z
4	tBodyAcc-std()-X	        timedBodyAccelerationSTD-X
5	tBodyAcc-std()-Y	        timedBodyAccelerationSTD-Y
6	tBodyAcc-std()-Z	        timedBodyAccelerationSTD-Z
7	tGravityAcc-mean()-X	    timedGravityAccelerationMean-X
8	tGravityAcc-mean()-Y	    timedGravityAccelerationMean-Y
9	tGravityAcc-mean()-Z	    timedGravityAccelerationMean-Z
10	tGravityAcc-std()-X	        timedGravityAccelerationSTD-X
11	tGravityAcc-std()-Y	        timedGravityAccelerationSTD-Y
12	tGravityAcc-std()-Z	        timedGravityAccelerationSTD-Z
13	tBodyAccJerk-mean()-X	    timedBodyAccelerationJerkSignalMean-X
14	tBodyAccJerk-mean()-Y	    timedBodyAccelerationJerkSignalMean-Y
15	tBodyAccJerk-mean()-Z	    timedBodyAccelerationJerkSignalMean-Z
16	tBodyAccJerk-std()-X	    timedBodyAccelerationJerkSignalSTD-X
17	tBodyAccJerk-std()-Y	    timedBodyAccelerationJerkSignalSTD-Y
18	tBodyAccJerk-std()-Z	    timedBodyAccelerationJerkSignalSTD-Z
19	tBodyGyro-mean()-X	        timedBodyAngularVelocityMean-X
20	tBodyGyro-mean()-Y	        timedBodyAngularVelocityMean-Y
21	tBodyGyro-mean()-Z	        timedBodyAngularVelocityMean-Z
22	tBodyGyro-std()-X	        timedBodyAngularVelocitySTD-X
23	tBodyGyro-std()-Y	        timedBodyAngularVelocitySTD-Y
24	tBodyGyro-std()-Z	        timedBodyAngularVelocitySTD-Z
25	tBodyGyroJerk-mean()-X	    timedBodyAngularVelocityJerkSignalMean-X
26	tBodyGyroJerk-mean()-Y	    timedBodyAngularVelocityJerkSignalMean-Y
27	tBodyGyroJerk-mean()-Z	    timedBodyAngularVelocityJerkSignalMean-Z
28	tBodyGyroJerk-std()-X	    timedBodyAngularVelocityJerkSignalSTD-X
29	tBodyGyroJerk-std()-Y	    timedBodyAngularVelocityJerkSignalSTD-Y
30	tBodyGyroJerk-std()-Z	    timedBodyAngularVelocityJerkSignalSTD-Z
31	tBodyAccMag-mean()	        timedBodyAccelerationMagnitudeMean
32	tGravityAccMag-mean()	    timedGravityAccelerationMagnitudeMean
33	tBodyAccJerkMag-mean()	    timedBodyAccelerationJerkSignalMagnitudeMean
34	tBodyGyroMag-mean()	        timedBodyAngularVelocityMagnitudeMean
35	tBodyGyroJerkMag-mean()	    timedBodyAngularVelocityJerkSignalMagnitudeMean
36	fBodyAcc-mean()-X	        freqBodyAccelerationMean-X
37	fBodyAcc-mean()-Y	        freqBodyAccelerationMean-Y
38	fBodyAcc-mean()-Z	        freqBodyAccelerationMean-Z
39	fBodyAcc-std()-X	        freqBodyAccelerationSTD-X
40	fBodyAcc-std()-Y	        freqBodyAccelerationSTD-Y
41	fBodyAcc-std()-Z	        freqBodyAccelerationSTD-Z
42	fBodyAccJerk-mean()-X	    freqBodyAccelerationJerkSignalMean-X
43	fBodyAccJerk-mean()-Y	    freqBodyAccelerationJerkSignalMean-Y
44	fBodyAccJerk-mean()-Z	    freqBodyAccelerationJerkSignalMean-Z
45	fBodyAccJerk-std()-X	    freqBodyAccelerationJerkSignalSTD-X
46	fBodyAccJerk-std()-Y	    freqBodyAccelerationJerkSignalSTD-Y
47	fBodyAccJerk-std()-Z	    freqBodyAccelerationJerkSignalSTD-Z
48	fBodyGyro-mean()-X	        freqBodyAngularVelocityMean-X
49	fBodyGyro-mean()-Y	        freqBodyAngularVelocityMean-Y
50	fBodyGyro-mean()-Z	        freqBodyAngularVelocityMean-Z
51	fBodyGyro-std()-X	        freqBodyAngularVelocitySTD-X
52	fBodyGyro-std()-Y	        freqBodyAngularVelocitySTD-Y
53	fBodyGyro-std()-Z	        freqBodyAngularVelocitySTD-Z
54	fBodyAccMag-mean()	        freqBodyAccelerationMagnitudeMean
55	fBodyBodyAccJerkMag-mean()	freqBodyBodyAccelerationJerkSignalMagnitudeMean
56	fBodyBodyGyroMag-mean()	    freqBodyBodyAngularVelocityMagnitudeMean
57	fBodyBodyGyroJerkMag-mean()	freqBodyBodyAngularVelocityJerkSignalMagnitudeMean
59		                        subject.id
60		                        activity

timed variables are measured in second and frequency in hertz
subject.id represents a participant's id
activity includes 6 activities: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
```

###Second Summary Tidy Data
The second tidy dataset created as part of the assignment groups the data based on activity (like walking, laying etc)
and finds the mean of all the other variables. This is a succint dataset that can be easily used for further analysis.