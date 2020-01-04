---
title: "README.md"
author: "Heather Oh"
output: html_document
---

## Introduction to the repository and items.

This repository contains a CodeBook, R scripts to create a tidy dataset from UCI HAR Dataset, and a resulting tidy dataset. This was created as a part of programming assignment for "Getting and Cleaning Data" course in Coursera. 

## R scripts

You may find the codes that clean up and extracts the data is available in run_analysis.R file. Sourcing the file in R using the following command will download the original UCI HAR Dataset from the Internet, perform data clean-up and save the result in tidydata.txt file, which is also found in this repo.  

```{r eval = FALSE}
source("run_analysis.R")
```

## Tidy data file

You can read the tidydata.txt file using the following command:  

```{r eval = FALSE}
tidydata <- data.table("tidydata.txt")
```

## CodeBook

Codebook of this tidydata.txt file is available ad well, providing the description on the original dataset, codes to execute data clean up process, and the lists of varibles in the final tidydata.txt.
