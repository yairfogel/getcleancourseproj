# getcleancourseproj
Getting and Cleaning Data course project

This project contains a script to reshape the data collected from the accelerometers from the Samsung Galaxy S smartphone, into a tidy dataset.
(original data is available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The script:

1. Downloads the original data

2. Merges the features and labels for the test and train datasets

3. Filter only mean and std columns

4. Merges the train and test datasets

5. Melts the unified dataset according to the subject and activity

6. Dcasts the dataset using the mean of every variable.

7. Write out the tidy dataset
