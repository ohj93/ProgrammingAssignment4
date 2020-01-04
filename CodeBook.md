---
title: "CodeBook for Tidydata fragment of UCI HAR Data"
author: "Heather Oh"
output: html_document
---

# CodeBook for Tidying up UCI HAR Dataset
This script was created to explicity handle UCI HAR data (University of California Irvin's Human Activity Recognition Dataset) into a tidydata set. The link to the original dataset is found [here](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones).  

You can read the tidy dataset of UCI HAR data into R by:

'''
tidydata <- data.table("tidydata.txt")
'''


## For What?
This script extracts the average of all the means and standard deviations variables from the original UCI HAR data, with a summarized, readable, and understandable variable names and labels. If you are interested in utilizing the mean average of from each measurements and activities from this dataset, this tidy set provides the essence of it.  
  
## Description of UCI HAR Dataset  
### Experiment Design
The HAR databased consist of the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waisted-mounted smartphone with embedded inertial sensors.  
The experiments have been carried out with 30 volunteered participants with age 18-48. Each person performed six different types f of activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone device (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the activity manually. The obtained dataset has been randomly divided into training and test data, for 70% and 30% of the participants, respectively.  
  
### Creation of the signals
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  
  
## Variables
The run_analysis script extracts four variables from the original UCI HAR Dataset.
1. subject
2. activity
3. measurement
4. mean  
  
### subject
Subject variable includes the ID numbers of 30 participants from the original UCI HAR Dataset. Each participant produced 396 measurements, resulting in 11,880 rows of data.  

### activity
Activity variable includes 6 types of activity labelled by the original experiment. The labels are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.  

### measurement
Measurement variable represents the type of measurement produced by the accelerometer and the gyroscope from the original experiment procedure. The total list of the measurement labels are the following:
* time-body-acceleration-mean-x  
* time-body-acceleration-mean-y
* time-body-acceleration-mean-z 
* time-body-acceleration-std-x
* time-body-acceleration-std-y
* time-body-acceleration-std-z
* time-gravity-acceleration-mean-x
* time-gravity-acceleration-mean-y
* time-gravity-acceleration-mean-z
* time-gravity-acceleration-std-x  
* time-gravity-acceleration-std-y
* time-gravity-acceleration-std-z
* time-body-acceleration-jerk-mean-x
* time-body-acceleration-jerk-mean-y 
* time-body-acceleration-jerk-mean-z
* time-body-acceleration-jerk-std-x
* time-body-acceleration-jerk-std-y
* time-body-acceleration-jerk-std-z
* time-body-gyroscope-mean-x
* time-body-gyroscope-mean-y
* time-body-gyroscope-mean-z
* time-body-gyroscope-std-x
* time-body-gyroscope-std-y
* time-body-gyroscope-std-z
* time-body-gyroscope-jerk-mean-x
* time-body-gyroscope-jerk-mean-y
* time-body-gyroscope-jerk-mean-z
* time-body-gyroscope-jerk-std-x
* time-body-gyroscope-jerk-std-y
* time-body-gyroscope-jerk-std-z
* time-body-acceleration-magnitude-mean
* time-body-acceleration-magnitude-std
* time-gravity-acceleration-magnitude-mean
* time-gravity-acceleration-magnitude-std
* time-body-acceleration-jerk-magnitude-mean
* time-body-acceleration-jerk-magnitude-std
* time-body-gyroscope-magnitude-mean
* time-body-gyroscope-magnitude-std
* time-body-gyroscope-jerk-magnitude-mean
* time-body-gyroscope-jerk-magnitude-std
* frequency-body-acceleration-mean-x
* frequency-body-acceleration-mean-y
* frequency-body-acceleration-mean-z
* frequency-body-acceleration-std-x
* frequency-body-acceleration-std-y
* frequency-body-acceleration-std-z
* frequency-body-acceleration-jerk-mean-x
* frequency-body-acceleration-jerk-mean-y
* frequency-body-acceleration-jerk-mean-z
* frequency-body-acceleration-jerk-std-x
* frequency-body-acceleration-jerk-std-y
* frequency-body-acceleration-jerk-std-z
* frequency-body-gyroscope-mean-x
* frequency-body-gyroscope-mean-y
* frequency-body-gyroscope-mean-z
* frequency-body-gyroscope-std-x
* frequency-body-gyroscope-std-y
* frequency-body-gyroscope-std-z
* frequency-body-acceleration-magnitude-mean
* frequency-body-acceleration-magnitude-std
* frequency-bodybody-acceleration-jerk-magnitude-mean
* frequency-bodybody-acceleration-jerk-magnitude-std
* frequency-bodybody-gyroscope-magnitude-mean
* frequency-bodybody-gyroscope-magnitude-std
* frequency-bodybody-gyroscope-jerk-magnitude-mean
* frequency-bodybody-gyroscope-jerk-magnitude-std  
  
The variable names are cleaned up from the original dataset by using the following codes.
```{r eval = FALSE}
descriptive_feature <- names(msddata)
descriptive_feature <- gsub("Acc", "-acceleration", descriptive_feature)
descriptive_feature <- gsub("Mag", "-magnitude", descriptive_feature)
descriptive_feature <- gsub("Jerk", "-jerk", descriptive_feature)
descriptive_feature <- gsub("Gyro", "-gyroscope", descriptive_feature)
descriptive_feature <- sub("^t", "time-", descriptive_feature)
descriptive_feature <- sub("^f", "frequency-", descriptive_feature)       
descriptive_feature <- gsub("\\(\\)", "", descriptive_feature)
descriptive_feature <- tolower(descriptive_feature)
```

### mean
Mean variable is a summarized data from the measurements. The summarized data was created by the following codes.

```{r eval = FALSE}
tidydata <- tbl_df(msddata) %>%
        group_by(subject, activity) %>%
        summarise_each(mean) %>%
        gather(measurement, mean, -subject, -activity)
```

The resulting tidydata is consist of 11,880 rows with 4 columns, with no missing data.

### References
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.  
