##Getting and Cleaning Data 
###Course Project - create tidy datasets from a freely available wearable computing study dataset

This cookbook is an exercise in taking a raw dataset from messy
to tidy according to the principles expressed in Getting and Cleanind Data
course and from Hadley Wickham's paper 
http://vita.had.co.nz/papers/tidy-data.pdf

Primarily, the philosophy includes
* Each variable forms a column
* Each observation froms a row
* Each type of observation unit forms a table

The following checklist can help identify obstacles to achieving tidy data
* Column headers are values, not variable names
* Multiple variables are stored in one column
* Variables are stored in both rows and columns
* Multiple types of observational units are stored in the same table
* A single observational unit is stored in multiple tables

####Dataset Info
* Source FileURL : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* FileName       : getdata-projectfiles-UCI HAR Dataset.zip
* Description    : Human Activity Recognition Using Smartphones Data Set 
* More Info      : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

####Cookbook steps contained in **run_analysis.R**
* The dataset is downloaded if not already present and then unzipped
* All the features present in the dataset is collected from **features.txt**
* Activities labels is read from another file **activity_lables.txt**
* Those labels are then merged with activites in training and testing directories based on id **test/y_test.txt train/y_train.txt**
* Participant in the study are collected independently for training and testing data **test/subject_test.txt train/subject_train.txt**
* Only features involving mean and standard deviation are selected based on regex
* Actual tests are then read from **test/X_test.txt train/X_train.txt**
* The test/train data then only retain features filtered earlier to id mean, std
* To create descriptive labels, the column names are then enhanced and augmented
* The test and train data are then merged with their respective participant and activities list
* Then the two dataset are finally merged together to produce the first tidy data set
* A second tidy dataset is then produced with the average of each variable for each activity and each subject
* An output file **tidyData.csv** is written to the current working directory
* At conclusion, a timer helps determine the total elapsed time for all activities performed

####How to Run
* the only recipe needed to run is **run_analysis.R** given a strong internet connection (source file is ~ 62.6mb)
* Unzipping file creates a directory ~ 285mb in size
* Due to the large dataset, provision enough memory, cores before running
* simply source run_analysis.R
* package required: dplyr
```
> source('~/Documents/datasciencecoursera/getting_and_cleaning_data/course_project/run_analysis.R')
Sample Script Output:
[1] "Current Working Directory /Users/don/Documents/datasciencecoursera/getting_and_cleaning_data/course_project"
[1] "Tidy data has been written to tidyData.csv in the current working directory"
[1] "Total elapsed time 33.5829999999987 s"
```

####Environment Tested
```
platform       x86_64-apple-darwin13.4.0   
arch           x86_64                      
os             darwin13.4.0                
system         x86_64, darwin13.4.0        
status                                     
major          3                           
minor          1.2                         
year           2014                        
month          10                          
day            31                          
svn rev        66913                       
language       R                           
version.string R version 3.1.2 (2014-10-31)
nickname       Pumpkin Helmet
```

####Files:
- cookbook.md  contains details about the original dataset and the variables for the new tidy datasets
- tidyData.csv  output of run_analysis.R which contains grouped summary of all columns by activity
- run_analysis.R  main recipe used to produce the tidy datasets from the source
- README.md  this file

####Notes:
Although this exercise particularly didn't involve melting and dcasting, the swirl excerise
using plyr, dplyr, tidyr packages was really helpful in understanding those principles together with
the actual paper by Hadley.
