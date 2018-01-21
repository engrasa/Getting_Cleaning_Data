
# Getting and Cleaning Data Course Project
## README.md


The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data for analysis. 


Source file is ```run_analysis.R```. This R script does the following things:

1. Merges the training and the test sets to create one data set.
    + Download and unzip the file.
    + Load subject, activity and features data.
    + Assign name to each column of the data.
    + Merge columns to get the data frame ```data_comp``` for all data.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
    + Subset the data frame ```data_comp``` by selected names of ```measurement_labels``` and create new data frame ```Finaldata```.

3. Uses descriptive activity names to name the activities in the data set
    + Factorize variable ```Activity``` in the data frame ```Finaldata``` using descriptive activity names.

4. Appropriately labels the data set with descriptive variable names.
    + For easy reference, change the name shortcuts and omit other unnecessary characters (e.g. ```-()```).

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + Create and save ```tidydata.txt```.

For more information, please see table below:


| NAME  | LINK |
| ------------- | ------------- |
| README  |  [README.md](https://github.com/mjchn/Getting_Cleaning_Data/blob/master/README.md)  |
| CODE BOOK  |  [CodeBook.md](https://github.com/mjchn/Getting_Cleaning_Data/blob/master/CodeBook.md)  |
| R SOURCE CODE  |  [run_analysis.R](https://github.com/mjchn/Getting_Cleaning_Data/blob/master/run_analysis.R)  |
| TIDY DATASET  |  [tidydata.txt](https://github.com/mjchn/Getting_Cleaning_Data/blob/master/tidydata.txt)  |
