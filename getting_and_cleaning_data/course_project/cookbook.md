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
ID  FeatureDescription
1	timedBodyAccelerationMean-X
2	timedBodyAccelerationMean-Y
3	timedBodyAccelerationMean-Z
4	timedBodyAccelerationSTD-X
5	timedBodyAccelerationSTD-Y
6	timedBodyAccelerationSTD-Z
7	timedGravityAccelerationMean-X
8	timedGravityAccelerationMean-Y
9	timedGravityAccelerationMean-Z
10	timedGravityAccelerationSTD-X
11	timedGravityAccelerationSTD-Y
12	timedGravityAccelerationSTD-Z
13	timedBodyAccelerationJerkSignalMean-X
14	timedBodyAccelerationJerkSignalMean-Y
15	timedBodyAccelerationJerkSignalMean-Z
16	timedBodyAccelerationJerkSignalSTD-X
17	timedBodyAccelerationJerkSignalSTD-Y
18	timedBodyAccelerationJerkSignalSTD-Z
19	timedBodyAngularVelocityMean-X
20	timedBodyAngularVelocityMean-Y
21	timedBodyAngularVelocityMean-Z
22	timedBodyAngularVelocitySTD-X
23	timedBodyAngularVelocitySTD-Y
24	timedBodyAngularVelocitySTD-Z
25	timedBodyAngularVelocityJerkSignalMean-X
26	timedBodyAngularVelocityJerkSignalMean-Y
27	timedBodyAngularVelocityJerkSignalMean-Z
28	timedBodyAngularVelocityJerkSignalSTD-X
29	timedBodyAngularVelocityJerkSignalSTD-Y
30	timedBodyAngularVelocityJerkSignalSTD-Z
31	timedBodyAccelerationMagnitudeMean
32	timedGravityAccelerationMagnitudeMean
33	timedBodyAccelerationJerkSignalMagnitudeMean
34	timedBodyAngularVelocityMagnitudeMean
35	timedBodyAngularVelocityJerkSignalMagnitudeMean
36	freqBodyAccelerationMean-X
37	freqBodyAccelerationMean-Y
38	freqBodyAccelerationMean-Z
39	freqBodyAccelerationSTD-X
40	freqBodyAccelerationSTD-Y
41	freqBodyAccelerationSTD-Z
42	freqBodyAccelerationJerkSignalMean-X
43	freqBodyAccelerationJerkSignalMean-Y
44	freqBodyAccelerationJerkSignalMean-Z
45	freqBodyAccelerationJerkSignalSTD-X
46	freqBodyAccelerationJerkSignalSTD-Y
47	freqBodyAccelerationJerkSignalSTD-Z
48	freqBodyAngularVelocityMean-X
49	freqBodyAngularVelocityMean-Y
50	freqBodyAngularVelocityMean-Z
51	freqBodyAngularVelocitySTD-X
52	freqBodyAngularVelocitySTD-Y
53	freqBodyAngularVelocitySTD-Z
54	freqBodyAccelerationMagnitudeMean
55	freqBodyBodyAccelerationJerkSignalMagnitudeMean
56	freqBodyBodyAngularVelocityMagnitudeMean
57	freqBodyBodyAngularVelocityJerkSignalMagnitudeMean
58	subject.id
59	activity
```

###Second Summary Tidy Data
The second tidy dataset created as part of the assignment groups the data based on activity (like walking, laying etc)
and finds the mean of all the other variables. This is a succint dataset that can be easily used for further analysis.