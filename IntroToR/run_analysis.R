run_analysis <- function() {
        
        #make sure we are in the right directory 
        setwd("UCI HAR Dataset")
        
        #read in the necessary files from this dir
        features   <- read.table("features.txt")
        activities <- read.table("activity_lables.txt")
        colnames(activities) <- c("activity_id", "activity")
        
        #go into the test training set
        setwd("test")
        #read the files from there
        labels_test  <- read.table("y_test.txt")
        subject_test <- read.table("subject_test.txt")
        data_test    <- read.table("X_test.txt")
        
        #go back to trainining dir to get the data we need there
        setwd("../train")
        #read in the files from here
        labels_train  <- read.table("y_train.txt")
        subject_train <- read.table("subject_test.txt")
        data_train    <- read.table("X_train.txt")
        
        #Step 1: Merge the data_train and data_test with rbind
        all_data <- rbind(data_test, data_train)
        #remove unused variables
        rm(data_test)
        rm(data_train)
        
        #Step 2: Extract only the measurements on the mean and standard deviation for each measurment
        #everything that has the words mean or std will be okay here
        features <- subset(features, grepl("(mean())|(std())", features$V2))
        #Remove all of the columns that are not mean() or std()
        all_data <- all_data[, features]
        #Rename the columns to their appropiate names 
        colnames(all_data) <- features$V2
        
        #Step 3: Use descriptive activity names to name the activities in the data set
        #combine both label data sets into one big one, in the same order as the all_data using rbind
        all_labels <- rbind(labels_test, labels_train)
        #remove unused variables
        rm(labels_test)
        rm(labels_train)
        
        #rename the all_labels column to activity_id
        colnames(all_labels) <- "activity_id"
        #add the labels dataset to the all_data 
        all_data <- cbind(all_labels, all_data)
        #merge the activity names with the activity_id 
        all_data <- merge(activity_labels, all_data)
        
        all_data
 }