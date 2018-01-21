library(plyr)
library(dplyr)
library(tidyr)
library(knitr)
library(data.table)

##CREATE A DIRECTORY TO STORE THE FILES FOR MODULE 3 PROJECT
if(!file.exists("./Module 3 Project"))
  {dir.create("./Module 3 Project")}

##DOWNLOAD THE FILES FROM THE UCI SITE
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./Module 3 Project/module3project.zip"))
  {download.file(url,destfile="./Module 3 Project/module3project.zip")}

##UNZIP THE DOWNLOADED FILE
if(!file.exists("./Module 3 Project/UCI HAR Dataset"))
  {unzip(zipfile="./Module 3 Project/module3project.zip",exdir="./Module 3 Project")}


##CREATE A FILEPATH FOR ALL UCI HAR DATA
path <- file.path("./Module 3 Project" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)

##LOAD TRAINING DATASETS
x_train <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
y_train <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
subject_train <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)

##LOAD TEST DATASETS
x_test  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)                       
y_test  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
subject_test  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

##LOAD LABEL DATASETS
feature_labels <- read.table(file.path(path,"features.txt"),header = FALSE)
activity_labels <- read.table(file.path(path,"activity_labels.txt"),header = FALSE)

##NAME VARIABLES
colnames(feature_labels) <- c('Index','featureName')
colnames(activity_labels) <- c('Activity','ActivityType')
colnames(x_train) <- feature_labels[,2] 
colnames(y_train) <-"Activity"
colnames(subject_train) <- "SubjectID"
colnames(x_test) <- feature_labels[,2] 
colnames(y_test) <- "Activity"
colnames(subject_test) <- "SubjectID"
 
##MERGE DATA
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
data_comp <- rbind(train, test)
#You may check the data if all columns have variables names
#You may run: View(head(data_comp,n=5)) to show first 5 rows or View(colnames(data_comp)) to see complete list of variable names

##EXTRACT MEAN and STD VARIABLES
mean_std<-feature_labels$featureName[grep("(mean|std)\\(\\)", feature_labels$featureName)]
measurement_labels<-c("SubjectID", "Activity",as.character(mean_std))
Finaldata<-subset(data_comp,select=measurement_labels)
Finaldata$Activity<-factor(Finaldata$Activity,labels=activity_labels[,2])
#You may check the data if all columns have variables names with mean() or std()
#You may run: str(Finaldata) or View(head(Finaldata,n=5)) to show first 5 rows or View(colnames(Finaldata)) to see list of selected variable names


##LABEL DATA with DESCRIPTIVE NAMES
names(Finaldata)<-gsub("[-()]", "", names(Finaldata))
names(Finaldata)<-gsub("mean", "Mean", names(Finaldata))
names(Finaldata)<-gsub("std", "Std", names(Finaldata))
names(Finaldata)<-gsub("Acc", "Accelerometer", names(Finaldata))
names(Finaldata)<-gsub("Gyro", "Gyroscope", names(Finaldata))
names(Finaldata)<-gsub("Mag", "Magnitude", names(Finaldata))
names(Finaldata)<-gsub("BodyBody", "Body", names(Finaldata))
names(Finaldata)<-gsub("^t", "Time", names(Finaldata))
names(Finaldata)<-gsub("^f", "Frequency", names(Finaldata))
#You may check the data if columns names have changed
#You may run: str(Finaldata) or View(head(Finaldata,n=5)) to show first 5 rows or View(colnames(Finaldata)) to see list of variable names

##CREATE TIDY DATASET
Tidydata<-aggregate(. ~SubjectID + Activity, Finaldata, mean)
Tidydata<-Tidydata[order(Tidydata$SubjectID,Tidydata$Activity),]
write.table(Tidydata, file = "tidydata.txt",row.name=FALSE,quote = FALSE, sep = '\t')
