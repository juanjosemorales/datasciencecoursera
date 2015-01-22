#Getting And Cleaning Data Course Project

##This repo includes the following:
* README.md file (this file)
* run_analysis.R
* CodeBook.md
* tidy_data_set.txt
* UCI HAR Dataset directory

The idea is to run the run_analysis.R script from the directory that contains the UCI HAR Dataset directory.
The run_analysis.R script will return an R data.frame() which, if written down as a txt file, will look like the tidy_data_set.txt 
The CodeBook.md file has more information about the resulting data set.

##Example Usage

setwd("THIS_DIRECTORY")

source("run_analysis.R")

table.write(run_analysis(), file="tidy_data_set.txt")
