
# author : Pierre-Yves Koenig

# Getting and Cleaning Data
# Course project


library(plyr)

# first, create a directory to put data if not exist
if(!file.exists("data")){
  dir.create("data")
}

# link to the archive containing the project data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download the archive
#download.file(fileUrl, destfile = "./data/HAR_Dataset.zip", method="curl")

# unzip the archive
#unzip("./data/HAR_Dataset.zip", exdir = "./data/")

# 1. Merges the training and the test sets to create one data set.

# read train and test data
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt", header = F, strip.white=TRUE)
dim(y_train)
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt", header = F, strip.white=TRUE)
dim(y_test)
y_merge <- rbind(y_train, y_test)
colnames(y_merge) <- "y"

X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", header = F, strip.white=TRUE)
dim(X_train)
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", header = F, strip.white=TRUE)
dim(X_test)
X_merge <- rbind(X_train, X_test)

feature <- read.table("data/UCI HAR Dataset/features.txt", header = F, strip.white=TRUE)
names(X_merge) <- feature[, 2]

subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", header = F, strip.white=TRUE)
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", header = F, strip.white=TRUE)
subject_merge <- rbind(subject_train, subject_test)  
colnames(subject_merge) <- "subject"


# merge all table together
mergedDataset <- data.frame(X_merge, y_merge, subject_merge)

# # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# read feature list
#feature <- read.table("data/UCI HAR Dataset/features.txt", header = F, strip.white=TRUE)

meanStdFeture <- feature[grepl('mean\\(|std\\(', feature$V2),]

meanStdFeture <- mutate(meanStdFeture, V2=gsub("-m", ".M", V2))
meanStdFeture <- mutate(meanStdFeture, V2=gsub("-s", ".S", V2))
meanStdFeture <- mutate(meanStdFeture, V2=gsub("-", ".", V2))
meanStdFeture <- mutate(meanStdFeture, V2=gsub("\\(\\)", "", V2))

# select only feature index where feature name contains mean() or std() 
meanStdFetureIndex <- meanStdFeture[,1]

#setup column names
meanStdFetureName <- meanStdFeture[,2]

# select column from X_merge according to mean and std list
mergedDataset_filtered <- mergedDataset[,c(meanStdFetureIndex, 562, 563 )]

names(mergedDataset_filtered) <- c(meanStdFetureName, "y", "subject")

# 3. Uses descriptive activity names to name the activities in the data set
activity_label <- read.table("data/UCI HAR Dataset/activity_labels.txt", header = F, strip.white=TRUE)
colnames(activity_label) <- c("activity_id", "activity_label")

#merge(y_merge, activity_label, by.x = "y" , by.y = "activity_id")
mergedDataset_filtered <- merge(mergedDataset_filtered, activity_label, by.x = "y" , by.y = "activity_id", all.x=TRUE, sort=FALSE)

# 4. Appropriately labels the data set with descriptive variable names.
# this part as already been done
# meanStdFeture <- mutate(meanStdFeture, V2=gsub("-m", ".M", V2))
# meanStdFeture <- mutate(meanStdFeture, V2=gsub("-s", ".S", V2))
# meanStdFeture <- mutate(meanStdFeture, V2=gsub("-", ".", V2))
# meanStdFeture <- mutate(meanStdFeture, V2=gsub("\\(\\)", "", V2))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
library(dplyr)
tidyData <- tbl_df(mergedDataset_filtered)

#ddply(tidyData, .(subject,y), summarize, foo = mean(fBodyAccMag.Std))

tidyMean <- tidyData %>% group_by(subject, y) %>% summarise_each(funs(ul = mean(.)))

write.csv(tidyMean, file = "data/tidyMean.txt",row.names = FALSE)
