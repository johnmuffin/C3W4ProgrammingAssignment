---
title: "Getting and Cleaning Data - Assignment - Script Documentation"
output: html_document
date: "2023-08-24"
---

For this assignment of getting and cleaning data, the objective was to transform the data set to be tidy and do some high level summary statistics on it. More specifically the objective of the assignment of the script are the following:

1. Merge the `test` and `training` data sets to become one data set that only extracts the **mean** and **standard deviation** measurements.
    - In addition, labels of the data set should have descriptive variables names.
2. Similarly, merge the `test` and `training` data sets to become one data set that have descriptive variables names and find the average of each variable for each **activity** and each **subject**.

### Libraries and Downloading the file in the workspace
- Within this section of the code libraries such as `data.table` and `dplyr` were initialized so that they can be used to help witn transforming the data. 
- A folder called `data` is created (if it doesn't exist already) to store the downloaded data.
- The variable `path` was creaed so that the path of where the files were located can be easily referenced later on.
```
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
```

### Reading the data
- From here on, the data downloaded was read into various variables, and given more descriptive variable names as provided within the metadata of the data.
- Based on the first objective the function `grep` was used to extract variable names that contained the *mean* or *standard devitation (std)*.
    - The filtered variable name vector was then used on the larger data table to subset the corresponding columns of interest.

```
featuresList = read.table(paste0(path,"features.txt"),col.names = c("feature_id","feature"))
measurementList = grep("mean|std\\(\\)",featuresList$feature)
measurementListNames = featuresList$feature[measurementList]
activityLabels = read.table(paste0(path,"activity_labels.txt"), col.names=c("activity_id","activity_label"))
```

### Transform the data - Using a function
- A function was created to simplify the process of transforming the data set.
- This function takes the following variables:
    - data - Name of the data set of either `train` or `test`
    - measurementList - Index vector of the measurements to be filtered for in the dataset (pre-defined in the section of reading data)
    - measurementListNames - Character vector of the measurements names to be filtered for in the dataset (pre-defined in the section of reading data)
    - activityLabels = Data frame of the activities and their corresponding ids.
- The function reads 3 different files within each `data` groups defined and transforms them correspondingly.
    1. Subject
        - Which is based off of the `subject_ .txt` file that gives the order of subject ids.
        - Reads the data into a table and gives the columns a descriptive name.
    2. X
        - Which is based off of the `X_ . txt` file that gives.
        - Reads the data into a table, filters on the columns of interested only based on `measurementList` and gives the columns a descriptive name based on the `measurementListNames` character vector.
    3. y
        - Which is based off of the `y_ .txt` file that gives the order of subject ids.
        - Reads the data into a table and gives the columns a descriptive name.
    - Afterwards, using the `cbind` function all the columns are merged together and the data was convereted to a data table for easier usage.

```
dataTransform = function (data,measurementList,measurementListNames,activityLabels) {
    subject = read.table(paste0(path,data,"/subject_",data,'.txt'), col.names=c("subject_id"))

    X = read.table(paste0(path,data,"/X_",data,'.txt'))
    X = X[,measurementList] %>% `colnames<-`(measurementListNames)

    y = read.table(paste0(path,data,"/y_",data,'.txt'),col.names="activity_id")
    y["activity"] = factor(y[,"activity_id"], levels = activityLabels$activity_id,labels=activityLabels$activity_label)
    dt = cbind(subject,y,X) %>% data.table
}
```

### **Goal #1** - Merging `test` and `train` data and filtering on **mean** and **standard deviation** measurements with the new data set having descriptive names
- Using the function in the previous step the data is simply read for both the `test` and `train` data set.
- Afterwards the `rbind` function was used to join the two tables together to create the final output.
```
# Use the function and appropriate defined parameters to get the data - mean, std variables
testdt1 = dataTransform("test",measurementList,measurementListNames,activityLabels)
traindt1 = dataTransform("train",measurementList,measurementListNames,activityLabels)
dt1 = rbind(testdt1,traindt1)
```

### **Goal #2** - Merging `test` and `train` data with the new data set having descriptive names, and averaging each measurement variable based on each **activity** and each **subject**
- A variable `featuresListLen` was created to reference the total amount of measurements found in the data set.
    - In addition, the variable is used to replace the `measurementList` and `measurementListNames` variables as those were pre-defined based on the goal of the first assignment.
- Using the same `dataTransform` function with different parameters the data set for `test` and `train` were created, and similarly was joined together using the `rbind` function.
- As noted in the `Codebook.md` there were a few duplicated measurement names so the `make.unique` and `names` function was used in combination to rename those duplicated measurement variable names.
- Because the table is in the class of a `data.table` the `group_by` function was used to identify the variables to group the data by which were `subject_id`,`activity_id`, and `activity`.
- Afterwards, the `summarize_all` function was used with the parameter of `mean` to find the average of each variable based on the groups defined (each **activity**, and each **subject**).
- Lastly, the summary is output as a `.txt` file for submission.

```
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
```
