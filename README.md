---
title: "README"
author: "Pierre-Yves Koenig"
date: "25/1/2015"
output: html_document
---

This README explains how all of the scripts work and how they are connected.



## Instruction

recalled the subject : Getting and Cleaning Data

Source dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

You should create one R script called run_analysis.R that does the following :

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## run_analysis.R

In this repo, you will find the script "run_analysis.R". This script aims to prepare tidy data from the data set of the project :

 - First a "data" directory is created (if it don't exisit).
 - The dataset archive will then be download
 - unziped
 - Merge operation are then accomplished answering
 - create output :
 
    - "data/tidyData.txt"" is created and represent the desired tidy dataset (i hope).
    - "data/tidyMeanData.txt"

## CodeBook.md

The CodeBook describes the variables, the data, and any transformations or work that I've performed to clean up the data.

## Information about my enviroment
```R
> version

platform       x86_64-pc-linux-gnu         
arch           x86_64                      
os             linux-gnu                   
system         x86_64, linux-gnu           
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
