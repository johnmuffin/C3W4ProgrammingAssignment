# Getting and Cleaning Data - Assignment
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# features_info = X_%.txt
# activity_labels = y_%.txt

# Initlize libraries and download files
library(data.table)
library(dplyr)

url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("data")){ # check if the directory exist
    dir.create("data") # create directory
}

download = download.file(url,destfile = "./data/dataset.zip")
extract = unzip(zipfile = "./data/dataset.zip",exdir="./data/dataset")

path = "./data/dataset/UCI Har Dataset/"

featuresList = read.table(paste0(path,"features.txt"),col.names = c("feature_id","feature"))
measurementList = grep("mean|std\\(\\)",featuresList$feature)
measurementListNames = featuresList$feature[measurementList]
activityLabels = read.table(paste0(path,"activity_labels.txt"), col.names=c("activity_id","activity_label"))

# Function to help read the data dynamically
dataTransform = function (data,measurementList,measurementListNames,activityLabels) {
    subject = read.table(paste0(path,data,"/subject_",data,'.txt'), col.names=c("subject_id"))

    X = read.table(paste0(path,data,"/X_",data,'.txt'))
    X = X[,measurementList] %>% `colnames<-`(measurementListNames)

    y = read.table(paste0(path,data,"/y_",data,'.txt'),col.names="activity_id")
    y["activity"] = factor(y[,"activity_id"], levels = activityLabels$activity_id,labels=activityLabels$activity_label)
    dt = cbind(subject,y,X) %>% data.table
}

# Use the function and appropriate defined parameters to get the data - mean, std variables
testdt1 = dataTransform("test",measurementList,measurementListNames,activityLabels)
traindt1 = dataTransform("train",measurementList,measurementListNames,activityLabels)
dt1 = rbind(testdt1,traindt1)

# Use the function and appropriate defined parameters to get the data - all variables
featuresListLen = length(featuresList$feature)

testdt2 = dataTransform(folderNames[1],1:featuresListLen,featuresList$feature[1:featuresListLen],activityLabels)
traindt2 = dataTransform(folderNames[2],1:featuresListLen,featuresList$feature[1:featuresListLen],activityLabels)
dt2 = rbind(testdt2,traindt2)

# fix duplicated names
names(dt2) <- make.unique(names(dt2))

# summarize results
dt <- group_by(dt2,subject_id,activity_id,activity)
dtSummary <- summarize_all(dt,mean)

# write results
write.table(dtSummary, "C3W4assignmentS5.txt" ,row.names = FALSE)
