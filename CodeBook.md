---
title: "Getting and Cleaning Data - Assignment"
output: html_document
date: "2023-08-24"
---

## Getting and Cleaning Data - Assignment

## Data Set Information

The data set used within this assignment is from [UC Irvine - Machine Learning Repository](http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones). As taken from the website, and file metadata:

### Information

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
>
> Check the README.txt file for further details about this dataset.
>
> A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: <http://www.youtube.com/watch?v=XOEN9W05_4A>
>
> An updated version of this dataset can be found at <http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions>. It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows.

### Has Missing Values?

> No

### Feature Selection

> Feature Selection
>
> =================
>
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
>
> These signals were used to estimate variables of the feature vector for each pattern:
>
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
> -   tBodyAcc-XYZ
>
> -   tGravityAcc-XYZ
>
> -   tBodyAccJerk-XYZ
>
> -   tBodyGyro-XYZ
>
> -   tBodyGyroJerk-XYZa
>
> -   tBodyAccMag
>
> -   tGravityAccMag
>
> -   tBodyAccJerkMag
>
> -   tBodyGyroMag
>
> -   tBodyGyroJerkMag
>
> -   fBodyAcc-XYZ
>
> -   fBodyAccJerk-XYZ
>
> <!-- -->
>
> -   fBodyGyro-XYZ
>
> -   fBodyAccMag
>
> -   fBodyAccJerkMag
>
> -   fBodyGyroMag
>
> -   fBodyGyroJerkMag
>
> The set of variables that were estimated from these signals are:
>
> -   mean(): Mean value
>
> -   std(): Standard deviation
>
> -   mad(): Median absolute deviation
>
> -   max(): Largest value in array
>
> -   min(): Smallest value in array
>
> -   sma(): Signal magnitude area
>
> -   energy(): Energy measure. Sum of the squares divided by the number of values.
>
> <!-- -->
>
> -   iqr(): Interquartile range
>
> -   entropy(): Signal entropy
>
> <!-- -->
>
> -   arCoeff(): Autorregresion coefficients with Burg order equal to 4
>
> -   correlation(): correlation coefficient between two signals
>
> -   maxInds(): index of the frequency component with largest magnitude
>
> -   meanFreq(): Weighted average of the frequency components to obtain a mean frequency
>
> -   skewness(): skewness of the frequency domain signal
>
> -   kurtosis(): kurtosis of the frequency domain signal
>
> -   bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
>
> -   angle(): Angle between to vectors.
>
> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
>
> -   gravityMean
>
> -   tBodyAccMean
>
> -   tBodyAccJerkMean
>
> -   tBodyGyroMean
>
> -   tBodyGyroJerkMean
>
> The complete list of variables of each feature vector is available in 'features.txt'

## Transformations on the Data

The specific transformations made on this data set was to rename sets of duplicated variables.


| **fBodyAcc-bandsEnergy()** | **fBodyAcc-AccJerk()** | **fBodyGyro-bandsEnergy()** |
| --- | --- | --- |
| fBodyAcc-bandsEnergy()-1,8   | fBodyAccJerk-bandsEnergy()-1,8   | fBodyGyro-bandsEnergy()-1,8   |
| fBodyAcc-bandsEnergy()-9,16  | fBodyAccJerk-bandsEnergy()-9,16  | fBodyGyro-bandsEnergy()-9,16  |
| fBodyAcc-bandsEnergy()-17,24 | fBodyAccJerk-bandsEnergy()-17,24 | fBodyGyro-bandsEnergy()-17,24 |
| fBodyAcc-bandsEnergy()-25,32 | fBodyAccJerk-bandsEnergy()-25,32 | fBodyGyro-bandsEnergy()-25,32 |
| fBodyAcc-bandsEnergy()-33,40 | fBodyAccJerk-bandsEnergy()-33,40 | fBodyGyro-bandsEnergy()-33,40 |
| fBodyAcc-bandsEnergy()-41,48 | fBodyAccJerk-bandsEnergy()-41,48 | fBodyGyro-bandsEnergy()-41,48 |
| fBodyAcc-bandsEnergy()-49,56 | fBodyAccJerk-bandsEnergy()-49,56 | fBodyGyro-bandsEnergy()-49,56 |
| fBodyAcc-bandsEnergy()-57,64 | fBodyAccJerk-bandsEnergy()-57,64 | fBodyGyro-bandsEnergy()-57,64 |
| fBodyAcc-bandsEnergy()-1,16  | fBodyAccJerk-bandsEnergy()-1,16  | fBodyGyro-bandsEnergy()-1,16  |
| fBodyAcc-bandsEnergy()-17,32 | fBodyAccJerk-bandsEnergy()-17,32 | fBodyGyro-bandsEnergy()-17,32 |
| fBodyAcc-bandsEnergy()-33,48 | fBodyAccJerk-bandsEnergy()-33,48 | fBodyGyro-bandsEnergy()-33,48 |
| fBodyAcc-bandsEnergy()-49,64 | fBodyAccJerk-bandsEnergy()-49,64 | fBodyGyro-bandsEnergy()-49,64 |
| fBodyAcc-bandsEnergy()-1,24  | fBodyAccJerk-bandsEnergy()-1,24  | fBodyGyro-bandsEnergy()-1,24  |
| fBodyAcc-bandsEnergy()-25,48 | fBodyAccJerk-bandsEnergy()-25,48 | fBodyGyro-bandsEnergy()-25,48 |

: Duplicated Variables

Each set of variables were duplicated 3 times in total.

The assumption was made based on the other non-duplicate variables, the conclusion was made that each respective duplicated represented to each axis of X, Y, and Z (in that order). Therefore for the sake of simplicity the function `make.unique()` was used to automatically assigned names to the duplicated values where the subsequent duplicated variable name has the suffix of `.x` where `x` is number of incidences of that respective duplicated variable - 1.

The first incidence of the variable name will not any fsuffix

> i.e., fBodyAccJerk-bandsEnergy()-1,8 --- *(first incidence)*
>
> fBodyAccJerk-bandsEnergy()-1,8.1 --- *(second incidence; 1st duplication)*

## Script

For more details on how the script works --- please refer to the `README.md` file.
