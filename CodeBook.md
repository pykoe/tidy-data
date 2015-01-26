---
title: "Code Book"
author: "Pierre-Yves Koenig"
date: "25/1/2015"
output: html_document
---

# Getting and Cleaning Data - Project - Code Book

This code book describes the variables, the data, and any transformations or work that I've performed to clean up the data.
A README.md file is also available

# Original Data

The original dataset is an archive : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.


### Download and unzip the archive

### Merge dataset train and test

The dataset is composed of differents files dans directories: 

- "activity_labels.txt"
- "features_info.txt"
- "features.txt"
- "README.txt"
- "test"
-- "test/Inertial Signals"
-- "test/subject_test.txt"
-- "test/X_test.txt"
-- "test/y_test.txt"

- "train"
-- "train/Inertial Signals"
-- "train/subject_train.txt"
-- "train/X_train.txt"
-- "train/y_train.txt"

The first operation is to merge train and test datas : 

- "/test/subject_test.txt" and "/train/subject_train.txt" -> the resulting table has 10299 observations and one variable (the variable is renamed as "subject")

- "/test/X_test.txt" and "/train/X_train.txt" -> the resulting table has 10299 observations and 561 variables

- "/test/y_test.txt" and "/train/y_train.txt" -> the resulting table has 10299 observations and 1 variable (the variable is renamed "y")

The second step is to merge all these table together resulting in a big table with 10299 observation and 

### Extracts only the measurements on the mean and standard deviation for each measurement.
The X dataset has 561 variable corresponding to features. In the feature.txt with have the associeted labels.

In order to keep only measurement of mean and std, we use the deature table to retrieve the list of corresponding variables

Here is the head of feature :  
```
  V1                V2
1  1 tBodyAcc-mean()-X
2  2 tBodyAcc-mean()-Y
3  3 tBodyAcc-mean()-Z
4  4  tBodyAcc-std()-X
5  5  tBodyAcc-std()-Y
6  6  tBodyAcc-std()-Z
7   7  tBodyAcc-mad()-X
8   8  tBodyAcc-mad()-Y
9   9  tBodyAcc-mad()-Z
10 10  tBodyAcc-max()-X
````
we will only keep variable with "mean" or "std" in their name. We also reformat the name in order to remove "-", "(", ")" characters. the resulting table contains 66 observation with two variale (index and "Variable Name")
```
     index             Variable Name
1     1           tBodyAcc.Mean.X
2     2           tBodyAcc.Mean.Y
3     3           tBodyAcc.Mean.Z
4     4            tBodyAcc.Std.X
5     5            tBodyAcc.Std.Y
6     6            tBodyAcc.Std.Z
41   41        tGravityAcc.Mean.X
42   42        tGravityAcc.Mean.Y
43   43        tGravityAcc.Mean.Z
44   44         tGravityAcc.Std.X
45   45         tGravityAcc.Std.Y
46   46         tGravityAcc.Std.Z
81   81       tBodyAccJerk.Mean.X
82   82       tBodyAccJerk.Mean.Y
83   83       tBodyAccJerk.Mean.Z
84   84        tBodyAccJerk.Std.X
85   85        tBodyAccJerk.Std.Y
86   86        tBodyAccJerk.Std.Z
121 121          tBodyGyro.Mean.X
122 122          tBodyGyro.Mean.Y
123 123          tBodyGyro.Mean.Z
124 124           tBodyGyro.Std.X
125 125           tBodyGyro.Std.Y
126 126           tBodyGyro.Std.Z
161 161      tBodyGyroJerk.Mean.X
162 162      tBodyGyroJerk.Mean.Y
163 163      tBodyGyroJerk.Mean.Z
164 164       tBodyGyroJerk.Std.X
165 165       tBodyGyroJerk.Std.Y
166 166       tBodyGyroJerk.Std.Z
201 201          tBodyAccMag.Mean
202 202           tBodyAccMag.Std
214 214       tGravityAccMag.Mean
215 215        tGravityAccMag.Std
227 227      tBodyAccJerkMag.Mean
228 228       tBodyAccJerkMag.Std
240 240         tBodyGyroMag.Mean
241 241          tBodyGyroMag.Std
253 253     tBodyGyroJerkMag.Mean
254 254      tBodyGyroJerkMag.Std
266 266           fBodyAcc.Mean.X
267 267           fBodyAcc.Mean.Y
268 268           fBodyAcc.Mean.Z
269 269            fBodyAcc.Std.X
270 270            fBodyAcc.Std.Y
271 271            fBodyAcc.Std.Z
345 345       fBodyAccJerk.Mean.X
346 346       fBodyAccJerk.Mean.Y
347 347       fBodyAccJerk.Mean.Z
348 348        fBodyAccJerk.Std.X
349 349        fBodyAccJerk.Std.Y
350 350        fBodyAccJerk.Std.Z
424 424          fBodyGyro.Mean.X
425 425          fBodyGyro.Mean.Y
426 426          fBodyGyro.Mean.Z
427 427           fBodyGyro.Std.X
428 428           fBodyGyro.Std.Y
429 429           fBodyGyro.Std.Z
503 503          fBodyAccMag.Mean
504 504           fBodyAccMag.Std
516 516  fBodyBodyAccJerkMag.Mean
517 517   fBodyBodyAccJerkMag.Std
529 529     fBodyBodyGyroMag.Mean
530 530      fBodyBodyGyroMag.Std
542 542 fBodyBodyGyroJerkMag.Mean
543 543  fBodyBodyGyroJerkMag.Std
```

We can now filter the merge dataset according to this table

The resulting table has 10299 observation 

For the activity, we just merge the content of the file activity_labels.txt with the filter table ( merge by "y" and activity_label)

