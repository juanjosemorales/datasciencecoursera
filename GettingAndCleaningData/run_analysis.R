run_analysis <- function() {
        
        #go the UCI HAR Dataset dir
        setwd("UCI HAR Dataset")
        #read in the necessary files from this dir
        features   <- read.table("features.txt")
        activities <- read.table("activity_labels.txt")
        colnames(activities) <- c("activity_id", "activity")
        #go into the test dir
        setwd("test")
        #read the files from there
        labels_test  <- read.table("y_test.txt")
        subject_test <- read.table("subject_test.txt")
        data_test    <- read.table("X_test.txt")
        #go back to training dir to get the data we need there
        setwd("../train")
        #read in the files from here
        labels_train  <- read.table("y_train.txt")
        subject_train <- read.table("subject_train.txt")
        data_train    <- read.table("X_train.txt")
        #go back to parent directory and load the dplyr library used later
        setwd("../..")
        library(dplyr)
        
        #Merge the data_train and data_test with rbind
        all_data <- rbind(data_test, data_train)
        #remove unused variables
        rm(data_test)
        rm(data_train)
        
        #Extract only the measurements on the mean and standard deviation for each measurment
        #everything that has the words mean or std will be okay here
        features <- subset(features, grepl("(mean())|(std())", features$V2))
        #Get only the columns with mean() or std()
        all_data <- all_data[, features$V1]
        #Rename the columns to their appropiate names 
        colnames(all_data) <- features$V2
        
        #Now merge the subjects and add them to the all_data
        all_subjects <- rbind(subject_test, subject_train)
        #remove unused variables
        rm(subject_test)
        rm(subject_train)
        #rename the V1 column in subjects to 'subject'
        colnames(all_subjects) <- "subject"
        #add the subject column to the merged training and test data
        all_data <- cbind(all_subjects, all_data)
        
        #combine both label data sets into one big one, in the same order as the all_data using rbind
        all_labels <- rbind(labels_test, labels_train)
        #rename the all_labels column to activity_id
        colnames(all_labels) <- "activity_id"
        #remove unused variables
        rm(labels_test)
        rm(labels_train)
        #add the labels dataset to the all_data with cbind
        all_data <- cbind(all_labels, all_data)
        #merge the activity names with the activity_id 
        all_data <- merge(activities, all_data)
        #remove the activity_id column
        all_data <- all_data[, -c(1)]
        
        #get the average of each variable and group it by activity, subject using dplyr
        all_data <- all_data %>% group_by(activity, subject) %>% summarise_each(funs(mean))
 }