## This script reads UCI HAR Dataset from the Internet, 
## loads the data in R, binds test and train data, creates
## readable and understandable data labels and variable labels,
## and create summarized mean dataset for each observation 
## and each activity data.

## 0. Get data.
## ------------------------------------------------------------------------
workingdirectory <- getwd()
filedirectory <- "UCI HAR Dataset/"

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("UCI HAR Dataset")) {
        if (!file.exists("UCI HAR Dataset")) {
                dir.create("UCI HAR Dataset")
        }
        download.file(fileUrl, destfile="data.zip", method="curl")
        unzip("data/data.zip", exdir="./")
        file.remove("data.zip")
}

setwd(filedirectory)

## 1. Merge 'training' and 'test' data.
## ------------------------------------------------------------------------
temp = read.table("features.txt", sep = "")
        featurenames = temp$V2

Xtrain = read.table("train/X_train.txt", sep = "")
        names(Xtrain) = featurenames
Ytrain = read.table("train/y_train.txt", sep = "")
        names(Ytrain) = "activity"
trainsubjects = read.table("train/subject_train.txt", sep = "")
        names(trainsubjects) = "subject"
        trainsubjects$subject = as.factor(trainsubjects$subject)
train = cbind(trainsubjects, Ytrain, Xtrain)


Xtest = read.table("test/X_test.txt", sep ="")
        names(Xtest) = featurenames
Ytest = read.table("test/y_test.txt", sep="")
        names(Ytest) = "activity"
testsubjects = read.table("test/subject_test.txt", sep = "")
        names(testsubjects) = "subject"
        testsubjects$subject = as.factor(testsubjects$subject)
test = cbind(testsubjects, Ytest, Xtest)

data <- rbind(train, test)


## 2. Extract only the measurements on means and stds for each measurements.
## ------------------------------------------------------------------------
featurenames <- c("subject", "activity", as.character(featurenames))
filterednames <- grepl("std|mean|subject|activity", featurenames) & !grepl("meanFreq", featurenames)
msddata <- data[,filterednames]

## 3. Use descriptive activity names to name the activities in the dataset.
## ------------------------------------------------------------------------
temp = read.table("activity_labels.txt", sep = "")
        activitylabel = as.character(temp$V2)
msddata$activity = as.factor(msddata$activity)
levels(msddata$activity) = activitylabel

## 4. Use descriptive variable names to label dataset.
## ------------------------------------------------------------------------
descriptive_feature <- names(msddata)
descriptive_feature <- gsub("Acc", "-acceleration", descriptive_feature)
descriptive_feature <- gsub("Mag", "-magnitude", descriptive_feature)
descriptive_feature <- gsub("Jerk", "-jerk", descriptive_feature)
descriptive_feature <- gsub("Gyro", "-gyroscope", descriptive_feature)
descriptive_feature <- sub("^t", "time-", descriptive_feature)
descriptive_feature <- sub("^f", "frequency-", descriptive_feature)       
descriptive_feature <- gsub("\\(\\)", "", descriptive_feature)
descriptive_feature <- tolower(descriptive_feature)
names(msddata) <- descriptive_feature

## 5. Create independent tidy data set with average of each variable for 
## each activity and each subject.
## ------------------------------------------------------------------------
tidydata <- tbl_df(msddata) %>%
        group_by(subject, activity) %>%
        summarise_each(mean) %>%
        gather(measurement, mean, -subject, -activity)

setwd(workingdirectory)
write.table(tidydata, "tidydata.txt")
